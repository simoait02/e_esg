import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceInfermier/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Accounttype extends StatefulWidget {
  const Accounttype({super.key});

  @override
  State<Accounttype> createState() => _AccounttypeState();
}

class _AccounttypeState extends State<Accounttype> {
  bool isJeune = false;
  bool isDoctor = false;
  bool isInfermier = false;

  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {Settings.isSystemSettings = prefs.getBool('isSystemSettings') ?? true;});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool darkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

    return Scaffold(
        backgroundColor: darkMode ? Color(0xff1a1a1e) : Color(0xffF5F5F6),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: height * 0.2,
              width: width,
              child: AutoSizeText(
                maxLines: 2,
                AppLocalizations.of(context)!.welcome,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: !darkMode ? const Color(0xff27272d) : Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isInfermier = false;
                  isDoctor = false;
                  isJeune = !isJeune;
                });
              },
              child: Container(
                height: height * 0.18,
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isJeune ? Color(0xff2F38A5) :!darkMode ? Colors.white : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:darkMode? Color(0xff9196CC):Color(0xffEAEBF6)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                        top: 0,
                        bottom: 0,
                        child: Image.asset("assets/images/youngpeople.png")),
                    Positioned(
                      left: width * 0.42,
                      top: height * 0.06,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.25,
                        child: AutoSizeText(
                          textDirection: TextDirection.rtl,
                          AppLocalizations.of(context)!.jeune,
                          maxLines: 1,
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            color:!darkMode?const Color(0xff141218) : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: () {
                setState(() {
                  isInfermier = false;
                  isDoctor = !isDoctor;
                  isJeune = false;
                });
              },
              child: Container(
                height: height * 0.18,
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isDoctor ? Color(0xff2F38A5) : !darkMode ? Colors.white : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: darkMode? Color(0xff9196CC):Color(0xffEAEBF6)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Image.asset("assets/images/doctors.png")),
                    Positioned(
                      left: width * 0.47,
                      top: height * 0.06,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.3,
                        child: AutoSizeText(
                          textDirection: TextDirection.rtl,
                          AppLocalizations.of(context)!.medecin,
                          maxLines: 1,
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            color:!darkMode?const Color(0xff141218) : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: () {
                setState(() {
                  isInfermier = !isInfermier;
                  isDoctor = false;
                  isJeune = false;
                });
              },
              child: Container(
                height: height * 0.18,
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isInfermier ?Color(0xff2F38A5) : !darkMode ? Colors.white : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: darkMode? Color(0xff9196CC):Color(0xffEAEBF6)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Image.asset("assets/images/nurses.png")),
                    Positioned(
                      left: width * 0.41,
                      top: height * 0.06,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.4,
                        child: AutoSizeText(
                          textDirection: TextDirection.rtl,
                          AppLocalizations.of(context)!.infirmier,
                          maxLines: 1,
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            color:!darkMode?const Color(0xff141218) : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Align(
              alignment: Alignment.center,
              child: CupertinoButton(
                child: Container(
                  height: height * 0.07,
                  width: width * 0.5,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    AppLocalizations.of(context)!.suivant,
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                ),
                onPressed: () {
                  if (isDoctor) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) => Cardi()),
                          (Route<dynamic> route) => false,
                    );
                  }
                  if(isJeune){
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) =>CardiJeune()),
                          (Route<dynamic> route) => false,
                    );
                  };
                  if(isInfermier){
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) =>CardiInf()),
                    );
                  };
                },
              ),
            ),
          ],
        ),
      );
  }
}
