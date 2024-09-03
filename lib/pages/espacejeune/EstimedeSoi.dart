import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'SideBar/Settings.dart';
import 'testpsy4.dart';

class EstimedeSoi extends StatefulWidget {
  const EstimedeSoi({Key? key}) : super(key: key);

  @override
  State<EstimedeSoi> createState() => EstimedeSoiState();
}

class EstimedeSoiState extends State<EstimedeSoi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentQuestionIndex = 0;
  List<bool> isHovered = List.generate(4, (index) => false);

  final List<String> questions = [];

  final List<List<int>> answerScores = [
    [4, 3, 2, 1],  
    [4, 3, 2, 1],  
    [1, 2, 3, 4],  
    [4, 3, 2, 1],  
    [1, 2, 3, 4],  
    [4, 3, 2, 1],  
    [4, 3, 2, 1],  
    [1, 2, 3, 4],  
    [1, 2, 3, 4],  
    [1, 2, 3, 4],  
  ];

  List<int> selfEsteemAnswers = [];
  int totalScore = 0;

  int calculateTotalScore() {
    totalScore = 0;
    for (int i = 0; i < selfEsteemAnswers.length; i++) {
      totalScore += answerScores[i][selfEsteemAnswers[i]];
    }
    return totalScore;
  }

  String interpretScore(int score) {
    if (score < 25) {
      return AppLocalizations.of(context)!.lowSelfEsteemMessage;
    } else if (score >= 25 && score < 31) {
      return AppLocalizations.of(context)!.mediumLowSelfEsteemMessage;
    } else if (score >= 31 && score < 34) {
      return AppLocalizations.of(context)!.mediumHighSelfEsteemMessage;
    } else if (score >= 34 && score <= 39) {
      return AppLocalizations.of(context)!.highSelfEsteemMessage;
    } else {
      return AppLocalizations.of(context)!.veryHighSelfEsteemMessage;
    }
  }

  void nextQuestion(int selectedIndex) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        if (selfEsteemAnswers.length > currentQuestionIndex) {
          selfEsteemAnswers[currentQuestionIndex] = selectedIndex;
        } else {
          selfEsteemAnswers.add(selectedIndex);
        }
        currentQuestionIndex++;
      });
    } else {
      if (selfEsteemAnswers.length > currentQuestionIndex) {
        selfEsteemAnswers[currentQuestionIndex] = selectedIndex;
      } else {
        selfEsteemAnswers.add(selectedIndex);
      }
      int totalScore = calculateTotalScore();
      String interpretation = interpretScore(totalScore);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.testCompleted),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Testpsy4(
              title: appLocalizations.evaluationTitle,
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
        selfEsteemAnswers.removeLast(); 
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
        appLocalizations.question1,
        appLocalizations.question2,
        appLocalizations.question3,
        appLocalizations.question4,
        appLocalizations.question5,
        appLocalizations.question6,
        appLocalizations.question7,
        appLocalizations.question8,
        appLocalizations.question9,
        appLocalizations.question10,
      ]);
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
      SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
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
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: Center(
                        child: Text(
                          appLocalizations.evaluationTitle,
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
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.04),
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
                                  '${currentQuestionIndex + 1}/10',
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
                                    margin: EdgeInsets.only(
                                        bottom: screenHeight * 0.02),
                                    padding:
                                        EdgeInsets.all(screenWidth * 0.03),
                                    decoration: BoxDecoration(
                                      color: isHovered[index]
                                          ? Colors.blue
                                          : Color.fromARGB(255, 4, 79, 140),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.02),
                                    ),
                                    child: Center(
                                      child: Text(
                                        index == 0
                                            ?  appLocalizations.stronglyDisagree
                                            : index == 1
                                                ? appLocalizations.disagree
                                                : index == 2
                                                    ? appLocalizations.agree
                                                    : appLocalizations.stronglyAgree,
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
