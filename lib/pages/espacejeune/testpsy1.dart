import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'SideBar/Settings.dart';
import 'testpsy2.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
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
                      SizedBox(height: 40),
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              appLocalizations.soutienPsychologique,
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
                                appLocalizations.lirePlus,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 213, 213, 213),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Center(
                              child: Text(
                                appLocalizations.bienEtreDescription,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              appLocalizations.commencezMaintenant,
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
                          color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0xffEAEBF6), width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              appLocalizations.nosTestsPsychologiques,
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
                              buttonText: appLocalizations.estimeDeSoi,
                              questionText: appLocalizations.estimeDeSoiQuestion,
                              description: appLocalizations.estimeDeSoiDescription,
                              imagePath: 'assets/images/estime_de_soi.png',
                              context: context,
                              index: 0,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
                              thickness: 1,
                              height: screenHeight * 0.02,
                            ),
                            PsychologicalTestButton(
                              buttonText: appLocalizations.paix,
                              questionText: appLocalizations.paixQuestion,
                              description: appLocalizations.paixDescription,
                              imagePath: 'assets/images/paix_interieure.jpg',
                              context: context,
                              index: 1,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
                              thickness: 1,
                              height: screenHeight * 0.02,
                            ),
                            PsychologicalTestButton(
                              buttonText: appLocalizations.humeur,
                              questionText: appLocalizations.humeurQuestion,
                              description: appLocalizations.humeurDescription,
                              imagePath: 'assets/images/humeur_vitalite.jpg',
                              context: context,
                              index: 2,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              color: Color(0xffEAEBF6),
                              thickness: 1,
                              height: screenHeight * 0.02,
                            ),
                            PsychologicalTestButton(
                              buttonText: appLocalizations.sommeil,
                              questionText: appLocalizations.sommeilQuestion,
                              description: appLocalizations.sommeilDescription,
                              imagePath: 'assets/images/sommeil.jpg',
                              context: context,
                              index: 3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
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
  required String description,
  required String imagePath,
  required BuildContext context,
  required int index,
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
                        builder: (context) => Testpsy2(
                          index: index,
                          description: description,
                          imagePath: imagePath,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 175, 182, 231)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12)),
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
