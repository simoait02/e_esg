import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';
import 'Acceuil.dart';



enum FoodType {
  FastFood,
  Cigarette,
  Vegetable,
  Fruit,
}

class Food {
  final FoodType type;
  final double left;
  double bottom;

  Food({
    required this.type,
    required this.left,
    required this.bottom,
  });
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double playerBottom = 0;
  bool isJumping = false;
  List<Food> foods = [];
  int score = 0;

  double gravity = -5.0;
  double jumpHeight = 80.0;
  double playerLeft = 0.0;
  double groundLevel = 10.0;

  int maxFoodPerBackground = 4;
  int foodCountPerBackground = 0;

  double backgroundX1 = 0;
  double backgroundX2 = 0;
  double backgroundWidth = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        final size = MediaQuery.of(context).size;
        backgroundWidth = size.width + 2;
        backgroundX2 = backgroundWidth;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 0, end: jumpHeight).animate(_controller)
      ..addListener(() {
        setState(() {
          playerBottom = _animation.value;
          checkCollision();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          isJumping = false;
          _descend();
        }
      });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (foodCountPerBackground < maxFoodPerBackground) {
        generateFood();
      }
    });

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        final size = MediaQuery.of(context).size;
        backgroundX1 -= 3;
        backgroundX2 -= 3;

        if (backgroundX1 <= -backgroundWidth) {
          backgroundX1 = backgroundWidth;
        }
        if (backgroundX2 <= -backgroundWidth) {
          backgroundX2 = backgroundWidth;
        }

        _moveFood();
      });
    });

    Timer(Duration(hours: 1), () {});

    accelerometerEvents.listen((AccelerometerEvent event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          jump();
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              left: backgroundX1,
              top: 0,
              width: backgroundWidth,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: backgroundX2,
              top: 0,
              width: backgroundWidth,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            ...foods.map((food) {
              Widget foodWidget;
              switch (food.type) {
                case FoodType.FastFood:
                  foodWidget = Image.asset('assets/images/fastfood.png', height: 37, width: 37);
                  break;
                case FoodType.Cigarette:
                  foodWidget = Image.asset('assets/images/cigarettes.png', height: 37, width: 37);
                  break;
                case FoodType.Vegetable:
                  foodWidget = Image.asset('assets/images/vegetable.png', height: 37, width: 37);
                  break;
                case FoodType.Fruit:
                  foodWidget = Image.asset('assets/images/fruit.png', height: 37, width: 37);
                  break;
              }
              return Positioned(
                left: food.left,
                bottom: food.bottom,
                child: foodWidget,
              );
            }).toList(),
            Positioned(
              left: playerLeft,
              bottom: groundLevel + playerBottom,
              child: GestureDetector(
                onTap: () {
                  jump();
                },
                child: Image.asset('assets/images/dinosaur.png', height: 70, width: 70),
              ),
            ),
            Positioned(
              top: 20.0,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Score: $score',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.favorite,
                          color: (score >= (index + 1) * 10) ? Colors.red : Colors.grey,
                          size: 30,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: ElevatedButton(
                onPressed: () {
                  moveLeft();
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: ElevatedButton(
                onPressed: () {
                  moveRight();
                },
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      _controller.forward(from: 0.0);
      gravity = 0.0;
    }
  }

  void _descend() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if (playerBottom > 0) {
          playerBottom -= 2;
        } else {
          playerBottom = 0;
          timer.cancel();
        }
        checkCollision();
      });
    });
  }

  void generateFood() {
    final random = Random();
    FoodType type;
    int foodTypeIndex = random.nextInt(4);
    switch (foodTypeIndex) {
      case 0:
        type = FoodType.FastFood;
        break;
      case 1:
        type = FoodType.Cigarette;
        break;
      case 2:
        type = FoodType.Vegetable;
        break;
      case 3:
        type = FoodType.Fruit;
        break;
      default:
        type = FoodType.Fruit;
    }

    double left = random.nextDouble() * MediaQuery.of(context).size.width;
    double bottom = MediaQuery.of(context).size.height;

    foods.add(Food(type: type, left: left, bottom: bottom));
    setState(() {});

    foodCountPerBackground++;
  }

  void _moveFood() {
    final double fallSpeed = 5.0;

    foods.removeWhere((food) {
      food.bottom -= fallSpeed;

      if (food.bottom < -50) {
        return true;
      }
      return false;
    });

    foodCountPerBackground = foods.length;
  }

  void checkCollision() {
    final double playerSize = 100;
    final double foodSize = 50;

    foods.removeWhere((food) {
      if (isJumping &&
          food.left < playerLeft + playerSize &&
          food.left + foodSize > playerLeft &&
          food.bottom < groundLevel + playerBottom + playerSize &&
          food.bottom + foodSize > groundLevel + playerBottom) {
        switch (food.type) {
          case FoodType.FastFood:
            score -= 10;
            break;
          case FoodType.Cigarette:
            score -= 10;
            break;
          case FoodType.Vegetable:
            score += 10;
            break;
          case FoodType.Fruit:
            score += 10;
            break;
        }
        return true;
      }
      return false;
    });

    if (score >= 50) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 239, 68),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'YOU WIN!',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.yellow.shade200,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'PLAY AGAIN?',
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                RevenirGame();
                              },
                              child: Text('No'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                resetGame();
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else if (score < 0) {
      showGameOverDialog();
    }
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'GAME OVER',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 28,
              color: Colors.red,
            ),
          ),
          content: Text(
            'PLAY AGAIN?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                resetGame();
              },
              child: Text('YES', style: TextStyle(fontFamily: 'PressStart2P')),
            ),
            TextButton(
              onPressed: () {
                RevenirGame();
              },
              child: Text('NO', style: TextStyle(fontFamily: 'PressStart2P')),
            ),
          ],
          backgroundColor: Colors.black,
        );
      },
    );
  }

  void RevenirGame() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Acceuil()),
    );
  }

  void resetGame() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => GameScreen()),
    );
  }

  void moveLeft() {
    setState(() {
      playerLeft -= 9;
      playerLeft = playerLeft.clamp(0, MediaQuery.of(context).size.width - 40);
    });
  }

  void moveRight() {
    setState(() {
      playerLeft += 9;
      playerLeft = playerLeft.clamp(0, MediaQuery.of(context).size.width - 40);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
