import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

import 'pages/espaceMedecin/LoginSignUp/Cardi.dart';

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
    setState(() {
      Cardi.isDarkMode.value = prefs.getBool('isDarkMode') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
      Settings.isSystemSettings = prefs.getBool('isSystemSettings') ?? true;
      Settings.isDark = prefs.getBool('isDark') ?? false;
      Settings.isLight = prefs.getBool('isLight') ?? false;
    });
    _setStatusBarStyle();
  }

  _setStatusBarStyle() {
    SystemUiOverlayStyle overlayStyle = Cardi.isDarkMode.value
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Settings.isSystemSettings
        ? Cardi.isDarkMode.value = (MediaQuery.of(context).platformBrightness == Brightness.dark)
        : !Settings.isDark
        ? Settings.isDark
        : Settings.isLight;
    _setStatusBarStyle();

    return Scaffold(
        backgroundColor: Cardi.isDarkMode.value ? Color(0xff1a1a1e) : Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: height * 0.2,
              width: width,
              child: AutoSizeText(
                "Select \n User Type",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: !Cardi.isDarkMode.value ? const Color(0xff27272d) : Colors.white,
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
                  color: isJeune ? Color(0xff00d3c7) : Color(0xb59799ef),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: Stack(
                  children: [
                    Image.asset("assets/images/jeune.png"),
                    Positioned(
                      left: width * 0.42,
                      top: height * 0.06,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.25,
                        child: AutoSizeText(
                          "Jeune",
                          maxLines: 1,
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  color: isDoctor ? Color(0xff00d3c7) : Color(0xb59799ef),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: Stack(
                  children: [
                    Image.asset("assets/images/doctor.png"),
                    Positioned(
                      left: width * 0.47,
                      top: height * 0.06,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.3,
                        child: AutoSizeText(
                          "Médcin",
                          maxLines: 1,
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                  color: isInfermier ? Color(0xff00d3c7) : Color(0xb59799ef),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: Stack(
                  children: [
                    Image.asset("assets/images/infermier.png"),
                    Positioned(
                      left: width * 0.41,
                      top: height * 0.06,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.4,
                        child: AutoSizeText(
                          "Infermier",
                          maxLines: 1,
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      colors: [Color(0xff0b40ff), Color(0xff0c40a4)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "Suivant",
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
                },
              ),
            ),
          ],
        ),
      );
  }
}
