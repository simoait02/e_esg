import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'testpsy4.dart';

class Anxiete extends StatefulWidget {
  const Anxiete({Key? key}) : super(key: key);

  @override
  State<Anxiete> createState() => AnxieteState();
}

class AnxieteState extends State<Anxiete> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentQuestionIndex = 0;
  List<bool> isHovered = List.generate(4, (index) => false);

  final List<String> questions = [
    "Je me sens tendu ou énervé.",
    "J'ai une sensation de peur comme si quelque chose d'horrible allait m'arriver.",
    "Je me fais du souci.",
    "Je peux rester tranquillement assis à ne rien faire et me sentir décontracté.",
    "J'éprouve des sensations de peur et j'ai l'estomac noué.",
    "J'ai la bougeotte et n'arrive pas à tenir en place.",
    "J'éprouve des sensations soudaines de panique.",
  ];

  final List<List<String>> answers = [
    ['Jamais', 'De temps en temps', 'Souvent', 'La plupart du temps'],
    ['Pas du tout', "Un peu mais cela ne m'inquiète pas", "Oui, mais ce n'est pas trop grave", "Oui, mais ce n'est pas trop grave"],
    ['Très occasionnellement', 'Occasionnellement', 'Assez souvent', 'Très souvent'],
    ["Oui, quoi qu'il arrive", 'Oui, en général', 'Rarement', 'Jamais'],
    ['Jamais', 'Parfois', 'Assez souvent', 'Très souvent'],
    ['Pas du tout', 'Pas tellement', 'Un peu', "Oui, c'est tout à fait le cas"],
    ['Jamais', 'Pas très souvent', 'Assez souvent', 'Vraiment très souvent'],
  ];

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vous avez terminé le test!'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Testpsy4(title: "Évaluation de la Paix Intérieure"),
          ),
        );
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDarkMode ? Color(0xff141218) : Color.fromARGB(255, 240, 235, 235),
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            name: "Simo",
            role: "Jeune",
            imagePath: 'assets/images/boy.png',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Center(
                        child: Text(
                          "Evaluation de la Paix Intérieure",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    Container(
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: previousQuestion,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/fleche.png",
                                  width: screenWidth * 0.03,
                                  height: screenWidth * 0.03,
                                ),
                                SizedBox(width: screenWidth * 0.01),
                                Text(
                                  "Précédent",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.039,
                                    color: Color.fromARGB(255, 4, 79, 140),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.48),
                                Text(
                                  '${currentQuestionIndex + 1}/7',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Color.fromARGB(255, 4, 79, 140),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            questions[currentQuestionIndex],
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return MouseRegion(
                                onEnter: (_) {
                                  setState(() {
                                    isHovered[index] = true;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    isHovered[index] = false;
                                  });
                                },
                                child: GestureDetector(
                                  onTap: nextQuestion,
                                  child: Container(
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.08,
                                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                                    padding: EdgeInsets.all(screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      color: isHovered[index]
                                          ? Colors.blue
                                          : Color.fromARGB(255, 4, 79, 140),
                                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                    ),
                                    child: Center(
                                      child: Text(
                                        answers[currentQuestionIndex][index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
