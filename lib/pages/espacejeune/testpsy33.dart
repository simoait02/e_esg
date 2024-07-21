import 'package:flutter/material.dart';
import 'dossierMedical.dart';
import 'ies.dart';
import 'testpsy1.dart';
import 'package:page_transition/page_transition.dart';

class Testpsy31 extends StatefulWidget {
  const Testpsy31({Key? key}) : super(key: key);

  @override
  State<Testpsy31> createState() => Testpsy31State();
}

class Testpsy31State extends State<Testpsy31> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 2;
  List<bool> isHovered = List.generate(4, (index) => false);
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  int currentQuestionIndex = 0;

  final List<String> questions = [
    "Je prends plaisir aux mêmes choses qu'autrefois.",
    "Je ris facilement et vois le bon côté des choses.",
    "Je suis de bonne humeur.",
    "J'ai l'impression de fonctionner au ralenti.",
    "Je me m'intéresse plus à mon apparence.",
    "Je me réjouis d'avance à l'idée de faire certaines choses.",
    "Je peux prendre plaisir à un bon livre ou à une bonne émission radio ou télévision.", 
  ];


  final List<List<String>> answers = [
    [
      'Oui,tout autant',
      'Pas autant',
      'Un peu seulement',
      'Presque plus'
    ],
    [
      'Autant que par le passé',
      "Plus autant qu'avant",
      "Vraiment moins qu'avant",
      "Plus du tout",
    ],
    [
      'La plupart du temps',
      'Assez souvent',
      'Rarement',
      'Jamais'
    ],
    [
      "J'y prête autant d'attention que par le passé",
      "Il se peut que je n'y fasse plus autant attention",
      "Je n'y accorde pas autant d'attention que je devrais",
      'Plus du tout'
    ],
    [
      'Jamais',
      'Parfois',
      'Très souvent',
      'Presque toujours'
    ],
    [
      "Autant qu'avant",
      "Un peu moins qu'avant",
      "Bien moins qu'avant",
      "Presque jamais",
    ],
    [
      'Souvent',
      'Parfois',
      'Rarement',
      'Très rarement',
    ],
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: Dossiermedical(),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: Ies(),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: Testpsy1(),
          ),
        );
        break;
    }
  }

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 240, 235, 235),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/images/menu.png'),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/logo.png', height: screenHeight * 0.1),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              child: Container(
                height: 150,
                color: Color.fromARGB(255, 17, 117, 199),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/images/messi.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 110,
                        child: Text(
                          'Lionel Messi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              leading: Icon(Icons.language),
              title: Text('Langues'),
              onTap: () {
                // Navigate to language settings
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: SwitchListTile(
                title: Text('Mode Sombre'),
                value: isDarkMode,
                onChanged: toggleDarkMode,
                secondary: Icon(Icons.brightness_6),
                activeColor: Colors.blue,
              ),
            ),
            SwitchListTile(
              title: Text('Notifications'),
              value: notificationsEnabled,
              onChanged: toggleNotifications,
              secondary: Icon(Icons.notifications),
              activeColor: Colors.blue,
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              leading: Icon(Icons.logout),
              title: Text('Déconnexion'),
              onTap: () {
                // Log out
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Center(
          child: SingleChildScrollView(
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
    );
  }
}
  