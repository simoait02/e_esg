import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'testpsy4.dart';

class Humeur extends StatefulWidget {
  const Humeur({Key? key}) : super(key: key);

  @override
  State<Humeur> createState() => HumeurState();
}

class HumeurState extends State<Humeur> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentQuestionIndex = 0;
  List<bool> isHovered = List.generate(4, (index) => false);

  final List<String> questions = [
    "Je prends plaisir aux mêmes choses qu'autrefois.",
    "Je ris facilement et vois le bon côté des choses.",
    "Je suis de bonne humeur.",
    "J'ai l'impression de fonctionner au ralenti.",
    "Je ne m'intéresse plus à mon apparence.",
    "Je me réjouis d'avance à l'idée de faire certaines choses.",
    "Je peux prendre plaisir à un bon livre ou à une bonne émission radio ou télévision.", 
  ];

  final List<List<String>> answers = [
    ['Oui, tout autant', 'Pas autant', 'Un peu seulement', 'Presque plus'],
    ['Autant que par le passé', "Plus autant qu'avant", "Vraiment moins qu'avant", "Plus du tout"],
    ['La plupart du temps', 'Assez souvent', 'Rarement', 'Jamais'],
    ["J'y prête autant d'attention que par le passé", "Il se peut que je n'y fasse plus autant attention", "Je n'y accorde pas autant d'attention que je devrais", 'Plus du tout'],
    ['Jamais', 'Parfois', 'Très souvent', 'Presque toujours'],
    ["Autant qu'avant", "Un peu moins qu'avant", "Bien moins qu'avant", "Presque jamais"],
    ['Souvent', 'Parfois', 'Rarement', 'Très rarement'],
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
          MaterialPageRoute(builder: (context) => Testpsy4(title: "Évaluation de l'Humeur et de la Vitalité")),
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
                          "Évaluation de l'Humeur et de la Vitalité",
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
                                          fontSize: screenWidth * 0.03,
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
