import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'testpsy2.dart';  
import '../../Widgets/custom_sliver_app_bar.dart';  

class Testpsy1 extends StatefulWidget {
  const Testpsy1({Key? key}) : super(key: key);

  @override
  State<Testpsy1> createState() => Testpsy1State();
}

class Testpsy1State extends State<Testpsy1> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff141218) : Color(0xffF5F5F6),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Soutien Psychologique et Bien être',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2E37A4),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                'assets/images/Image.jpg',
                                height: screenHeight * 0.3,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Lire plus",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 213, 213, 213),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Center(
                              child:Text(
                                "Prenez un moment pour vous, pour votre bien-être. Nos tests interactifs sont conçus pour vous aider à explorer votre état émotionnel de manière douce et positive. En répondant à quelques questions simples, vous obtiendrez des insights précieux sur votre santé mentale et des conseils personnalisés pour vous sentir mieux au quotidien.Ce petit geste peut avoir un grand impact sur votre qualité de vie.",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Commencez dès maintenant et découvrez des chemins vers une vie plus épanouie et équilibrée. Vous méritez de vous sentir bien.",
                              style: TextStyle(
                                  fontSize: 10,
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
                          color: isDarkMode ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Nos Tests Psychologiques :',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2E37A4),
                              ),
                            ),
                            Divider(
                              color: Color(0xff9999A3),
                              thickness: 2,
                              height: screenHeight * 0.02,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            PsychologicalTestButton(
                              buttonText: "Estime de soi",
                              questionText: 'Est-ce que Vous Avez Confiance en Vous-Même ?',
                              title: "Evaluation de l'Estime de soi",
                              description: "L’estime de soi est définie comme le jugement ou l’évaluation que l’on fait de soi-même, de sa valeur personnelle. De façon plus simple, l’estime de soi peut-être également assimilée à l’affirmation de soi. L’estime de soi est un facteur essentiel dans la performance sportive.",
                              imagePath: 'assets/images/estime_de_soi.png',
                              context: context,
                              route: Testpsy2(
                                title: "Evaluation de l'Estime de Soi",
                                description: "L’estime de soi est définie comme le jugement ou l’évaluation que l’on fait de soi-même, de sa valeur personnelle. De façon plus simple, l’estime de soi peut-être également assimilée à l’affirmation de soi. L’estime de soi est un facteur essentiel dans la performance sportive.",
                                imagePath: 'assets/images/estime_de_soi.png',
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
                              thickness: 1,
                              height: screenHeight * 0.02,
                            ),
                            PsychologicalTestButton(
                              buttonText: 'Paix',
                              questionText: 'Êtes-vous en Paix avec Vous-Même ?',
                              title: "Evaluation de la Paix Intérieure",
                              description: "Plongez dans votre tranquillité intérieure pour comprendre et maîtriser votre niveau d'anxiété.",
                              imagePath: 'assets/images/paix_interieure.jpg',
                              context: context,
                              route: Testpsy2(
                                title: "Evaluation de la Paix Intérieure",
                                description: "Plongez dans votre tranquillité intérieure pour comprendre et maîtriser votre niveau d'anxiété.",
                                imagePath: 'assets/images/paix_interieure.jpg',
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
                              thickness: 1,
                              height: screenHeight * 0.02,
                            ),
                            PsychologicalTestButton(
                              buttonText: 'Humeur',
                              questionText: 'Est-ce que Votre Humeur et Vitalité sont Équilibrées ?',
                              title: "Evaluation de l'Humeur et de la Vitalité",
                              description: "Explorez votre humeur et découvrez des moyens de retrouver votre vitalité émotionnelle pour une vie plus équilibrée.",
                              imagePath: 'assets/images/humeur_vitalite.jpg',
                              context: context,
                              route: Testpsy2(
                                title: "Evaluation de l'Humeur et de la Vitalité",
                                description: "Explorez votre humeur et découvrez des moyens de retrouver votre vitalité émotionnelle pour une vie plus équilibrée.",
                                imagePath: 'assets/images/humeur_vitalite.jpg',
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
                              thickness: 1,
                              height: screenHeight * 0.02,
                            ),
                            PsychologicalTestButton(
                              buttonText: 'Sommeil',
                              questionText: 'Est-ce que Votre Qualité de Sommeil Est Satisfaisante ?',
                              title: "Evaluation de la qualité de sommeil ",
                              description: "Évaluez votre sommeil pour mieux comprendre ses impacts sur votre bien-être quotidien et trouver des solutions pour améliorer votre repos.",
                              imagePath: 'assets/images/sommeil.jpg',
                              context: context,
                              route: Testpsy2(
                                title: "Evaluation de la qualité de sommeil ",
                                description: "Évaluez votre sommeil pour mieux comprendre ses impacts sur votre bien-être quotidien et trouver des solutions pour améliorer votre repos.",
                                imagePath: 'assets/images/sommeil.jpg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight*0.1,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget PsychologicalTestButton({
  required String buttonText,
  required String questionText,
  required String title,
  required String description,
  required String imagePath,
  required BuildContext context,
  required Widget route,
}) {
  var screenWidth = MediaQuery.of(context).size.width;
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: screenWidth * 0.17,
            width: screenWidth * 0.2,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 255, 255, 255), 
                width: 2, 
              ),
              borderRadius: BorderRadius.circular(5), 
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5), 
              child: Image.asset(
                imagePath, 
                height: screenWidth * 0.2,
                width: screenWidth * 0.2,
                fit: BoxFit.cover, 
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => route,
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 175, 182, 231)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8, horizontal: 12)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), 
                      ),
                    ),
                  ),
                  child: Text(buttonText),
                ),
                SizedBox(height: 6),
                Text(
                  questionText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
