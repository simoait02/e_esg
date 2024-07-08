import 'package:flutter/material.dart';
import 'dossierMedical.dart';
import 'ies.dart';
import 'testpsy1.dart';

class Testpsy4 extends StatefulWidget {
  const Testpsy4({super.key});

  @override
  State<Testpsy4> createState() => Testpsy4State();
}

class Testpsy4State extends State<Testpsy4> {
  int selectedIndex = 2;


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
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Center(
                    child: Text(
                      "Evaluation de l'Humeur et de la Vitalité",
                      style: TextStyle(
                        fontSize: 16,
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
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Merci d'avoir complèté le test",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        "assets/images/taches.png",
                        width: 160,
                        height: 160,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/testpsy5');
                        },
                        child: Text(
                          "Résultat du test",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                        "Revenir aux tests psychologiques",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
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
