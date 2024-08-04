import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'testpsy4.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



const List<Map<String, dynamic>> tests = [
  {
    'title': "RONFLEMENT",
    'parts': [
      {
        'title': "FREQUENCE",
        'choix': ["Ronfle souvent", "Ronfle en permanence"]
      },
      {
        'title': "QUALITE",
        'choix': ["Ronflement intense", "Respiration bruyante"]
      },
    ],
  },
  {
    'title': "DIFFICULTES RESPIRATOIRES",
    'parts': [
      {
        'choix': ["Respiration irrégulière", "Apnées constatées"]
      },
    ],
  },
  {
    'title': "RESPIRATION BUCCALE",
    'parts': [
      {
        'choix': ["Bouche ouverte pendant la journée", "Bouche sèche au réveil"]
      },
    ],
  },
  {
    'title': "SOMNOLENCE DIURNE",
    'parts': [
      {
        'choix': ["Fatigue au réveil", "Endormissement diurne", "Endormissement à l'école", "Difficulté à se réveiller"]
      },
    ],
  },
  {
    'title': "TROUBLES ATTENTION / HYPERACTIVITE",
    'parts': [
      {
        'choix': ["N'écoute pas", "Inorganisé", "Aisément distrait", "Bouge", "Toujours actif", "S'interrompt au cours d'une activité"]
      },
    ],
  },
  {
    'title': "AUTRES",
    'parts': [
      {
        'choix': ["Enurésie nocturne", "Maux de tête", "Retard de croissance", "Obésité"]
      },
    ],
  },
];

class Sommeil extends StatefulWidget {
  const Sommeil({Key? key}) : super(key: key);

  @override
  State<Sommeil> createState() => SommeilState();
}

class SommeilState extends State<Sommeil> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentTestIndex = 0;
  List<List<List<int>>> responses = []; 
  List<bool> testCompleted = []; 

  final List<int> answerScores = [0, 1]; 
  int totalScore = 0;

  @override
  void initState() {
    super.initState();
    for (var test in tests) {
      responses.add(List.generate(
          test['parts'].length,
          (_) => List.filled(test['parts'][0]['choix'].length, -1))); 
      testCompleted.add(false);
    }
  }

  void calculateTotalScore() {
    totalScore = 0; 

    for (var testResponses in responses) {
      for (var partResponses in testResponses) {
        for (var response in partResponses) {
          if (response == 1) { 
            totalScore += answerScores[response];
          }
        }
      }
    }

    print("Total Score: $totalScore"); 
  }

  String interpretScore(int score) {
    if (score <= 8) {
      return "Votre évaluation indique que vous n'avez pas de signes significatifs de troubles du sommeil. Continuez à maintenir de bonnes habitudes de sommeil pour garantir votre bien-être. Si vous ressentez des symptômes perturbants, consultez un professionnel de la santé.";
    } else {
      return "Vos résultats indiquent des problèmes potentiels de sommeil. Il est recommandé de consulter un professionnel de la santé pour une évaluation plus approfondie et des conseils personnalisés. Entre-temps, explorez nos ressources pour des conseils sur l'amélioration de la qualité du sommeil.";
    }
  }

  void recordResponse(int partIndex, int choiceIndex, int subChoiceIndex) {
    setState(() {
      responses[currentTestIndex][partIndex][subChoiceIndex] = choiceIndex;

      bool allAnswered = responses[currentTestIndex][partIndex].every((response) => response != -1);
      testCompleted[currentTestIndex] = allAnswered;
    });
  }

  void nextTest() {
    if (currentTestIndex < tests.length - 1) {
      setState(() {
        currentTestIndex++;
      });
    } else {
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

  void previousTest() {
  if (currentTestIndex > 0) {
    setState(() {
      currentTestIndex--;
    });
  }
 }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    var currentTest = tests[currentTestIndex];
    var parts = currentTest['parts'];

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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Évaluation de la qualité de sommeil",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
      onTap: previousTest,
      child: Row(
        children: [
          Image.asset(
            "assets/images/fleche.png",
            width: screenWidth * 0.025,
            height: screenWidth * 0.025,
          ),
          SizedBox(width: screenWidth * 0.01),
          Text(
            "Précédent",
            style: TextStyle(
              fontSize: screenWidth * 0.039,
              color: Color.fromARGB(255, 4, 79, 140),
            ),
          ),
        ],
      ),
    ),
    SizedBox(width: screenWidth * 0.48),
    Text(
      '${currentTestIndex + 1}/${tests.length}',
      style: TextStyle(
        fontSize: screenWidth * 0.03,
        color: Color.fromARGB(255, 4, 79, 140),
      ),
    ),
  ],
),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            currentTest['title'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          for (int i = 0; i < parts.length; i++) ...[
                            if (i > 0) SizedBox(height: screenHeight * 0.02),
                            Text(
                              parts[i]['title'] ?? '',
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(parts[i]['choix'].length, (subChoiceIndex) {
                                String choice = parts[i]['choix'][subChoiceIndex];
                                return Container(
                                  width: screenWidth * 0.9,
                                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          choice,
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.03,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => recordResponse(i, 1, subChoiceIndex),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  responses[currentTestIndex][i][subChoiceIndex] == 1
                                                      ? Icons.radio_button_checked
                                                      : Icons.radio_button_unchecked,
                                                  size: screenWidth * 0.05,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(width: screenWidth * 0.02),
                                                Text(
                                                  'Oui',
                                                  style: TextStyle(
                                                    fontSize: screenWidth * 0.03,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.04),
                                          GestureDetector(
                                            onTap: () => recordResponse(i, 0, subChoiceIndex),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  responses[currentTestIndex][i][subChoiceIndex] == 0
                                                      ? Icons.radio_button_checked
                                                      : Icons.radio_button_unchecked,
                                                  size: screenWidth * 0.05,
                                                  color: Colors.blue,
                                                ),
                                                SizedBox(width: screenWidth * 0.02),
                                                Text(
                                                  'Non',
                                                  style: TextStyle(
                                                    fontSize: screenWidth * 0.03,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                          SizedBox(height: screenHeight * 0.02),
                          Row(children: [
                            Row(
  children: [
    GestureDetector(
      onTap: () {
        if (testCompleted[currentTestIndex]) {
          nextTest();
        }
      },
      child: Row(
        children: [
          SizedBox(width: screenWidth * 0.55),
          Text(
            "Suivant",
            style: TextStyle(
              fontSize: screenWidth * 0.039,
              color: Color.fromARGB(255, 4, 79, 140),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Icon(
            Icons.arrow_forward,
            size: screenWidth * 0.05,
            color: Colors.blue,
          ),
        ],
      ),
    ),
  ],
)

                          ],)
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
