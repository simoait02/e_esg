import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/testpsy5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Color(0xffF5F5F6),
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
                    border: Border.all(color: Color(0xffEAEBF6), width: 2),
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
                    border: Border.all(color: Color(0xffEAEBF6), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "Merci d'avoir compléter le test",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      SvgPicture.asset(
                        "assets/images/tick-circle.svg",
                        width: 160,
                        height: 160,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Testpsy5())),
                        child: Text(
                          "Résultat du test",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff9196CD),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Testpsy1())),
                        child: Text(
                        "Revenir aux tests psychologiques",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff00D3C7),
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
    );
  }
}
