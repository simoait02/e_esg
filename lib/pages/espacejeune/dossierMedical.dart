import 'package:flutter/material.dart';
import 'dossiermedical.dart';
import 'ies.dart';
import 'testpsy1.dart';

class Dossiermedical extends StatefulWidget {
  const Dossiermedical({super.key});

  @override
  State<Dossiermedical> createState() => DossiermedicalState();
}

class DossiermedicalState extends State<Dossiermedical> {
  int selectedIndex = 0;

  final Map<String, String> infos = {
    "Nom": "Marquina",
    "Prénom": "Sergio",
    "Sexe": "Masculin",
    "Né le": "20/07/2000",
    "E-mail": "sergiomarquina@gmail.com",
    "Telephone": "0685123456",
    "Scolarité": "Non",
    "CIN": "XD465264",
    "Antécédants Médicaux":
        "De 10/07/2023 a 24/07/2024 \n -hépatique \n -fievre",
    "Antécédants Chirurgicaux": "Oui",
    "Antécédants familiaux": "tttt",
  };

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dossiermedical()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Ies()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
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
          icon: Icon(Icons.menu),
          onPressed: () {
            print('afficher menu');
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
                  width: screenWidth * 1,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Changer la photo de profil');
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.15,
                          backgroundImage:
                              AssetImage('assets/images/Sedraty.png'),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: infos.length,
                        separatorBuilder: (context, index) => Divider(
                          color: const Color.fromARGB(255, 194, 193, 193),
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          String key = infos.keys.elementAt(index);
                          String value = infos[key]!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenWidth * 0.3,
                                  child: Text(
                                    "$key ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(value),
                                    ],
                                  ),
                                ),
                              ],
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
