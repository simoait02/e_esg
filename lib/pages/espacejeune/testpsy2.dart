import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'SideBar/Settings.dart';
import 'Estime de Soi.dart';
import 'Anxiété.dart';
import 'Humeur.dart';
import 'Sommeil.dart';
import 'testpsy4.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Testpsy2 extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;

  const Testpsy2({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<Testpsy2> createState() => Testpsy2State();
}

class Testpsy2State extends State<Testpsy2> {
  bool isHovered = false;

  void _navigateBasedOnTitle() {
    final appLocalizations = AppLocalizations.of(context)!;
    Widget destination;
    switch (widget.title) {
      case "Évaluation de l'Estime de soi" || "تقييم تقدير الذات" || "Self-Esteem Evaluation":
        destination = EstimedeSoi();
        break;
      case "Évaluation de la Paix Intérieure" || "تقييم السلام الداخلي" || "Inner Peace Assessment":
        destination = Anxiete();
        break;
      case "Evaluation de l'Humeur et de la Vitalité" || "تقييم المزاج والحيوية" || "Mood and Vitality Assessment":
        destination = Humeur();
        break;
      default:
        destination = Sommeil();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name: "Simo",
              role: "Jeune",
              imagePath: 'assets/images/boy.png',
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
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
                          color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(
                                widget.imagePath,
                                height: screenHeight * 0.3,
                                width: screenWidth * 0.8,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            MouseRegion(
                              onEnter: (_) {
                                setState(() {
                                  isHovered = true;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  isHovered = false;
                                });
                              },
                              child: GestureDetector(
                                onTap: _navigateBasedOnTitle,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015,
                                    horizontal: screenWidth * 0.1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isHovered ? Colors.green : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.commencerLeTest,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isHovered
                                          ? Color.fromARGB(255, 78, 244, 217)
                                          : Color.fromARGB(255, 194, 194, 194),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
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
            )
          ],
        ),
      ),
    );
  }
}

