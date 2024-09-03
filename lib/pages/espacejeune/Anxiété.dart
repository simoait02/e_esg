import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'SideBar/Settings.dart';
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

  final List<String> questions = [];

  final List<int> answerScores = [0, 1, 2, 3];

  List<int> jeuneAnswers = [];
  int totalScore = 0;

  void calculateTotalScore() {
    totalScore = 0;
    for (int i = 0; i < jeuneAnswers.length; i++) {
      totalScore += answerScores[jeuneAnswers[i]];
    }
  }

  String interpretScore(int score) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (score < 8) {
      return appLocalizations.interpretation_low;
    } else if (score >= 8 && score < 10) {
      return appLocalizations.interpretation_moderate;
    } else {
      return appLocalizations.interpretation_high;
    }
  }

  void nextQuestion(int selectedIndex) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        if (jeuneAnswers.length > currentQuestionIndex) {
          jeuneAnswers[currentQuestionIndex] = selectedIndex;
        } else {
          jeuneAnswers.add(selectedIndex);
        }
        currentQuestionIndex++;
      });
    } else {
      if (jeuneAnswers.length > currentQuestionIndex) {
        jeuneAnswers[currentQuestionIndex] = selectedIndex;
      } else {
        jeuneAnswers.add(selectedIndex);
      }
      calculateTotalScore();
      String interpretation = interpretScore(totalScore);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.testCompleted),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Testpsy4(
              title: appLocalizations.paixTitle,
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
        jeuneAnswers.removeLast();
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
        appLocalizations.question_1,
        appLocalizations.question_2,
        appLocalizations.question_3,
        appLocalizations.question_4,
        appLocalizations.question_5,
        appLocalizations.question_6,
        appLocalizations.question_7,
      ]);
    }

    final List<List<String>> answers = [
      [
        appLocalizations.answer_1_1,
        appLocalizations.answer_1_2,
        appLocalizations.answer_1_3,
        appLocalizations.answer_1_4
      ],
      [
        appLocalizations.answer_2_1,
        appLocalizations.answer_2_2,
        appLocalizations.answer_2_3,
        appLocalizations.answer_2_4
      ],
      [
        appLocalizations.answer_3_1,
        appLocalizations.answer_3_2,
        appLocalizations.answer_3_3,
        appLocalizations.answer_3_4
      ],
      [
        appLocalizations.answer_4_1,
        appLocalizations.answer_4_2,
        appLocalizations.answer_4_3,
        appLocalizations.answer_4_4
      ],
      [
        appLocalizations.answer_5_1,
        appLocalizations.answer_5_2,
        appLocalizations.answer_5_3,
        appLocalizations.answer_5_4
      ],
      [
        appLocalizations.answer_6_1,
        appLocalizations.answer_6_2,
        appLocalizations.answer_6_3,
        appLocalizations.answer_6_4
      ],
      [
        appLocalizations.answer_7_1,
        appLocalizations.answer_7_2,
        appLocalizations.answer_7_3,
        appLocalizations.answer_7_4
      ],
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
      SettingsYong.isDarkMode.value ? const Color(0xff141218) : const Color(0xffF5F5F6),
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
                        color:  SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Center(
                        child: Text(
                          appLocalizations.anxiete_title,
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
                                    color: const Color.fromARGB(255, 4, 79, 140),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.48),
                                Text(
                                  '${currentQuestionIndex + 1}/7',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: const Color.fromARGB(255, 4, 79, 140),
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
                                    margin: EdgeInsets.only(
                                        bottom: screenHeight * 0.02),
                                    padding: EdgeInsets.all(screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      color: isHovered[index]
                                          ? Colors.blue
                                          : const Color.fromARGB(255, 4, 79, 140),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.02),
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
