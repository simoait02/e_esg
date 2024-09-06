import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'SideBar/Settings.dart';
import 'testpsy4.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Humeur extends StatefulWidget {
  const Humeur({Key? key}) : super(key: key);

  @override
  State<Humeur> createState() => HumeurState();
}

class HumeurState extends State<Humeur> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentQuestionIndex = 0;
  List<bool> isHovered = List.generate(4, (index) => false);

  final List<String> questions = [];

  final List<int> answerScores = [0, 1, 2, 3];

  List<int> humeurAnswers = [];
  int totalScore = 0;

  void calculateTotalScore() {
    totalScore = 0;
    for (int i = 0; i < humeurAnswers.length; i++) {
      totalScore += answerScores[humeurAnswers[i]];
    }
  }

  String interpretScore(int score) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (score < 8) {
      return  appLocalizations.resultGoodMood;
    } else if (score >= 8 && score <= 10) {
      return appLocalizations.resultModerateMood;
    } else {
      return appLocalizations.resultConcernedMood;
    }
  }

  void nextQuestion(int selectedIndex) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        if (humeurAnswers.length > currentQuestionIndex) {
          humeurAnswers[currentQuestionIndex] = selectedIndex;
        } else {
          humeurAnswers.add(selectedIndex);
        }
        currentQuestionIndex++;
      });
    } else {
      if (humeurAnswers.length > currentQuestionIndex) {
        humeurAnswers[currentQuestionIndex] = selectedIndex;
      } else {
        humeurAnswers.add(selectedIndex);
      }
      calculateTotalScore();
      String interpretation = interpretScore(totalScore);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:  Text(AppLocalizations.of(context)!.testCompleted),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Testpsy4(
              title:appLocalizations.humeurTitle,
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
        humeurAnswers.removeLast(); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context)!;


    
    if (questions.isEmpty) {
      questions.addAll([
        appLocalizations.question1H,
        appLocalizations.question2H,
        appLocalizations.question3H,
        appLocalizations.question4H,
        appLocalizations.question5H,
        appLocalizations.question6H,
        appLocalizations.question7H,
      ]);
    }
    final List<List<String>> answers = [
        [appLocalizations.answer1Option0, appLocalizations.answer1Option1, appLocalizations.answer1Option2, appLocalizations.answer1Option3],
        [appLocalizations.answer2Option0, appLocalizations.answer2Option1, appLocalizations.answer2Option2, appLocalizations.answer2Option3],
        [appLocalizations.answer3Option0, appLocalizations.answer3Option1, appLocalizations.answer3Option2, appLocalizations.answer3Option3],
        [appLocalizations.answer4Option0, appLocalizations.answer4Option1, appLocalizations.answer4Option2, appLocalizations.answer4Option3],
        [appLocalizations.answer5Option0, appLocalizations.answer5Option1, appLocalizations.answer5Option2, appLocalizations.answer5Option3],
        [appLocalizations.answer6Option0, appLocalizations.answer6Option1, appLocalizations.answer6Option2, appLocalizations.answer6Option3],
        [appLocalizations.answer7Option0, appLocalizations.answer7Option1, appLocalizations.answer7Option2, appLocalizations.answer7Option3],
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: SettingsYong.isDarkMode.value ? const Color(0xff141218) : const Color(0xffF5F5F6),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.all(screenWidth * 0.05),
                      decoration: BoxDecoration(
                        color: SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Center(
                        child: Text(
                          appLocalizations.humeurTitle,
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
                        color: SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.white,
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
                                  appLocalizations.previous_button,
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
                                  onTap: () => nextQuestion(index),
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

