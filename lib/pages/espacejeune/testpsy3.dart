import 'package:flutter/material.dart';
import 'dossierMedical.dart';
import 'ies.dart';
import 'testpsy1.dart';
class Testpsy3 extends StatefulWidget {
  const Testpsy3({Key? key}) : super(key: key);

  @override
  State<Testpsy3> createState() => Testpsy3State();
}

class Testpsy3State extends State<Testpsy3> {
  int selectedIndex = 2;
  List<bool> isHovered = List.generate(4, (index) => false);

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dossiermedical()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ies()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Testpsy1()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 235, 235),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('assets/images/menu.png'),
          onPressed: () {
            print('Afficher le menu');
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: screenHeight * 0.1),
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
                        onTap: () {
                          Navigator.pop(context); 
                        },
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
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        "Je prends plaisir aux mêmes choses qu’autrefois.",
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
                              onTap: () {
                                Navigator.pushNamed(context, '/testpsy4');
                              },
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
                                        ? 'Oui, tout autant.'
                                        : index == 1
                                            ? 'Pas autant.'
                                            : index == 2
                                                ? 'Un peu seulement.'
                                                : 'Presque plus.',
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/DossierMedical.png',
              height: screenHeight * 0.04,
              width: screenWidth * 0.1,
            ),
            label: 'Dossier Médical',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/healthcare.png',
              height: screenHeight * 0.04,
              width: screenWidth * 0.1,
            ),
            label: 'IES',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/test.png',
              height: screenHeight * 0.04,
              width: screenWidth * 0.1,
            ),
            label: 'Test Psychologique',
          ),
        ],
      ),
    );
  }
}


