import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/testpsy2.dart';
import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'dossiermedical.dart';
import 'ies.dart';

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

    return Scaffold(
      backgroundColor: Color(0xffF5F5F6),
      body:SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name: "Simo",
              role: "Jeune",
              imagePath: 'assets/images/boy.png',
            ),
            SliverToBoxAdapter(
              child: Padding(
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
                          border: Border.all(color: Color(0xffEAEBF6),width: 2)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Soutien Psychologique et Bien-être',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),textAlign: TextAlign.center,
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
                            Center(
                              child: AutoSizeText(
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
                          border: Border.all(color: Color(0xffEAEBF6),width: 2)
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
                              buttonText: 'Estime de soi',
                              questionText:
                              'Est-ce que Vous Avez Confiance en Vous Meme ?',
                              context: context,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
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
                              color: Color(0xffEAEBF6),
                              thickness: 1,
                              height: screenHeight * 0.02,
                            ),
                            PsychologicalTestButton(
                              buttonText: 'Humeur',
                              questionText:
                              'Est-ce que Votre humeur et Vitalité sont équilibrées ?',
                              context: context,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
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
            )
          ],
        ),
      )
    );
  }

  Widget PsychologicalTestButton({
    required String buttonText,
    required String questionText,
    required BuildContext context,
  }) {
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>Testpsy2())),
      child: Container(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
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
                    onPressed: () { },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Color(0xff9199CE)),
                      foregroundColor: WidgetStateProperty.all<Color>(
                          Colors.white),
                    ),
                    child: Text(buttonText),
                  ),
                  SizedBox(height: 8),
                  AutoSizeText(
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
}
