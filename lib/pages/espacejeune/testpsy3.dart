import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/pages/espacejeune/testpsy4.dart';
import 'package:e_esg/pages/espacejeune/testpsy5.dart';
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
      backgroundColor: Color(0xffF5F5F6),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name: "Simo",
              role: "Jeune",
              imagePath: 'assets/images/boy.png',
            ),
            SliverPadding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
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
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
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
                                    color: Color(0xff2E37A4),
                                  ),
                                  SizedBox(width: screenWidth * 0.01),
                                  Text(
                                    "Précédent",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.039,
                                      color: Color(0xff2E37A4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            AutoSizeText(
                              "Je prends plaisir aux mêmes choses qu’autrefois.",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Testpsy4())),
                                    child: Container(
                                      width: screenWidth * 0.4,
                                      height: screenHeight * 0.08,
                                      margin: EdgeInsets.only(
                                          bottom: screenHeight * 0.02),
                                      padding: EdgeInsets.all(screenWidth * 0.03),
                                      decoration: BoxDecoration(
                                        color: isHovered[index]
                                            ? Colors.blue
                                            : Color(0xff9196CD),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth * 0.02),
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
          ],
        ),
      ),
    );
  }
}
