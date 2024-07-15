import 'package:flutter/material.dart';
import 'dossierMedical.dart';
import 'ies.dart';
import 'testpsy1.dart';

class Testpsy5 extends StatefulWidget {
  const Testpsy5({super.key});

  @override
  State<Testpsy5> createState() => Testpsy5State();
}

class Testpsy5State extends State<Testpsy5> {
  int selectedIndex = 2;
  final Map<String, String> infos = {
    "Identifiant": "01",
    "Nom et Prénom": "nom prenom",
    "Date du test": "4/7/2024 16/1/17",
    "Score": "9",
  };

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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:isDarkMode?Color(0xff141218):Color(0xffF5F5F6),
      appBar: AppBar(
        backgroundColor:isDarkMode?Color(0xff141218):Colors.white,
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
                    border: Border.all(color: Color(0xffEAEBF6),width: 2)
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
                      color:isDarkMode?Color(0xff141218):Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Color(0xffEAEBF6),width: 2)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vos informations",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2E37A4),
                        ),
                      ),
                      SizedBox(height: 6),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: infos.length,
                        itemBuilder: (context, index) {
                          String key = infos.keys.elementAt(index);
                          String value = infos[key]!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  "$key :",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Text(value),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  decoration: BoxDecoration(
                      color:isDarkMode?Color(0xff141218):Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Color(0xffEAEBF6),width: 2)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Interprétation du résultat",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2E37A4),
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
