import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
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

  final List<String> questions = [
    "Je pense que je suis une personne de valeur, au moins égale à n'importe qui d'autre.",
    "Je pense que je possède un certain nombre de belles qualités.",
    "Tout bien considéré, je suis porté à me considérer comme un raté.",
    "Je suis capable de faire les choses aussi bien que la majorité des gens.",
    "Je sens peu de raisons d'être fier de moi.",
    "J'ai une attitude positive vis-à-vis moi-même.",
    "Dans l'ensemble, je suis satisfait de moi.",
    "J'aimerais avoir plus de respect pour moi-même.",
    "Parfois je me sens vraiment inutile.",
    "Il m'arrive de penser que je suis un bon à rien."
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
          MaterialPageRoute(builder: (context) => Testpsy4(title: "Evaluation de l'Estime de soi")),
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
                          "Evaluation de l'Estime de soi",
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
                                        index == 0
                                            ? 'Tout à fait en désaccord.'
                                            : index == 1
                                                ? 'Plutôt en désaccord.'
                                                : index == 2
                                                    ? 'Plutôt en accord.'
                                                    : 'Tout à fait en accord.',
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
