import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'testpsy4.dart';

class Sommeil extends StatefulWidget {
  const Sommeil({Key? key}) : super(key: key);

  @override
  State<Sommeil> createState() => SommeilState();
}

class SommeilState extends State<Sommeil> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentQuestionIndex = 0;
  List<bool> isHovered = List.generate(2, (index) => false);

  final List<String> questions = [
    "Ronflez-vous fréquemment la nuit ?",
    "Ronflez-vous en continu pendant la nuit ?",
    "Votre ronflement est-il très bruyant ?",
    "Avez-vous une respiration bruyante pendant le sommeil ?",
    "Avez-vous une respiration irrégulière pendant le sommeil ?",
    "Avez-vous déjà été observé(e) en train de faire des pauses respiratoires pendant le sommeil ?",
    "Avez-vous tendance à garder la bouche ouverte pendant la journée ?",
    "Votre bouche est-elle souvent sèche lorsque vous vous réveillez ?",
    "Vous sentez-vous fatigué(e) au réveil ?",
    "Avez-vous tendance à vous endormir pendant la journée ?",
    "Vous endormez-vous souvent à l'école ou au travail ?",
    "Avez-vous des difficultés à vous réveiller le matin ?",
    "Avez-vous des difficultés à écouter et à prêter attention ?",
    "Avez-vous tendance à être désorganisé(e) ?",
    "Êtes-vous facilement distrait(e) ?",
    "Avez-vous du mal à rester immobile ?",
    "Êtes-vous toujours en mouvement ?",
    "Interrompez-vous souvent vos activités ?",
    "Avez-vous des épisodes d'énurésie nocturne (fait d'uriner involontairement pendant le sommeil) ?",
    "Souffrez-vous souvent de maux de tête ?",
    "Avez-vous un retard de croissance ?",
    "Avez-vous des problèmes de poids ou d'obésité ?",
  ];

  final List<List<String>> answers = [
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
    ['oui', 'non'],
  ];

  final List<int> answerScores = [1, 0];

  List<int> sommeilAnswers = [];
  int totalScore = 0;

  void calculateTotalScore() {
    totalScore = 0;
    for (int i = 0; i < sommeilAnswers.length; i++) {
      totalScore += answerScores[sommeilAnswers[i]];
    }
  }

  String interpretScore(int score) {
    if (score <= 8) {
      return "Votre évaluation indique que vous n'avez pas de signes significatifs de troubles du sommeil. Continuez à maintenir de bonnes habitudes de sommeil pour garantir votre bien-être. Si vous ressentez des symptômes perturbants, consultez un professionnel de la santé.";
    } else {
      return "Vos résultats indiquent des problèmes potentiels de sommeil. Il est recommandé de consulter un professionnel de la santé pour une évaluation plus approfondie et des conseils personnalisés. Entre-temps, explorez nos ressources pour des conseils sur l'amélioration de la qualité du sommeil.";
    }
  }

  void nextQuestion(int selectedIndex) {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        if (sommeilAnswers.length > currentQuestionIndex) {
          sommeilAnswers[currentQuestionIndex] = selectedIndex;
        } else {
          sommeilAnswers.add(selectedIndex);
        }
        currentQuestionIndex++;
      });
    } else {
      if (sommeilAnswers.length > currentQuestionIndex) {
        sommeilAnswers[currentQuestionIndex] = selectedIndex;
      } else {
        sommeilAnswers.add(selectedIndex);
      }
      calculateTotalScore();
      String interpretation = interpretScore(totalScore);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vous avez terminé le test!'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Testpsy4(
              title: "Évaluation de la qualité de sommeil",
              score: totalScore,
              interpretation: interpretation,
            ),
          ),
        );
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        sommeilAnswers.removeLast();
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
                          "Evaluation de la qualité de sommeil",
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
                                  '${currentQuestionIndex + 1}/${questions.length}',
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
                            itemCount: answers[currentQuestionIndex].length,
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
                                  onTap: () => nextQuestion(index),
                                  child: Container(
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.08,
                                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                                    padding: EdgeInsets.all(screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      color: isHovered[index] ? Colors.blue : Color.fromARGB(255, 4, 79, 140),
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
