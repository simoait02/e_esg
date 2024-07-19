import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/testpsy5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'testpsy1.dart';

class Testpsy4 extends StatefulWidget {
  final String title;

  const Testpsy4({super.key, required this.title});

  @override
  State<Testpsy4> createState() => Testpsy4State();
}

class Testpsy4State extends State<Testpsy4> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff141218) : Color(0xffF5F5F6),
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 14,
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
                          color: isDarkMode ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Merci d'avoir complété le test",
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
                                      builder: (context) => Testpsy5(title:widget.title))),
                              child: Text(
                                "Résultat du test",
                                style: TextStyle(
                                  fontSize: 13,
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
                                  fontSize: 13,
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
          ),
        ],
      ),
    );
  }
}
