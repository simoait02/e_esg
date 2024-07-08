import 'package:flutter/material.dart';
import 'dossiermedical.dart';
import 'ies.dart';
import 'testpsy1.dart';

class Testpsy1 extends StatefulWidget {
  const Testpsy1({Key? key}) : super(key: key);

  @override
  State<Testpsy1> createState() => Testpsy1State();
}

class Testpsy1State extends State<Testpsy1> {
  int selectedIndex = 2;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Soutien Psychologique et Bien-être',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'assets/images/Image.jpeg',
                        height: screenHeight * 0.3,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Lire plus",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: Text(
                        'Lorem ipsum dolor sit amet. Eos commodi labore sed ipsum error non excepturi veritatis eum voluptatibus voluptates. Qui deleniti deleniti aut nihil excepturi et dolore quisquam et natus quia ut necessitatibus natus est deserunt minus et ipsum voluptas.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Nos Tests Psychologiques :',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.07),
                        Text(
                          'Show all',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 19, 26, 37),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    PsychologicalTestButton(
                      buttonText: 'Estime de soi',
                      questionText:
                          'Est-ce que Vous Avez Confiance en Vous Meme ?',
                      context: context,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: screenHeight * 0.02,
                    ),
                    PsychologicalTestButton(
                      buttonText: 'Paix',
                      questionText: 'Etes-vous en Paix avec Vous meme ?',
                      context: context,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: screenHeight * 0.02,
                    ),
                    PsychologicalTestButton(
                      buttonText: 'Humeur',
                      questionText:
                          'Est-ce que Votre humeur et Vitalité sont équilibrées ?',
                      context: context,
                      navigateTo: '/testpsy2',
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: screenHeight * 0.02,
                    ),
                    PsychologicalTestButton(
                      buttonText: 'Sommeil',
                      questionText:
                          'Est-ce que Votre Qualité de sommeil Est Satisfaisante ?',
                      context: context,
                    ),
                  ],
                ),
              ),
            ],
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

  Widget PsychologicalTestButton({
    required String buttonText,
    required String questionText,
    required BuildContext context,
    String? navigateTo,
  }) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'assets/images/ROAR.png',
              height: screenWidth * 0.2,
              width: screenWidth * 0.2,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (navigateTo != null) {
                        Navigator.pushNamed(context, navigateTo);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade400),
                    ),
                    child: Text(buttonText),
                  ),
                  SizedBox(height: 8),
                  Text(
                    questionText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
