import 'package:auto_size_text/auto_size_text.dart';
import 'package:chiclet/chiclet.dart';
import 'package:e_esg/AccountType.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chooselanguage extends StatefulWidget {
  final void Function(Locale locale) onLanguageChanged;

  const Chooselanguage({super.key, required this.onLanguageChanged});

  @override
  State<Chooselanguage> createState() => _ChooselanguageState();
}

class _ChooselanguageState extends State<Chooselanguage> {
  bool en = false;
  bool fr = false;
  bool ar = false;
  _savePreferences(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("language", value);
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool darkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darkMode?const Color(0xff141218) : Color(0xffF5F5F6),
      body: Builder(
        builder: (context) {
          final appLocalizations = AppLocalizations.of(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05),
              Text(
                appLocalizations!.language,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 30,color:!darkMode?const Color(0xff141218) : Colors.white, ),
              ),
              SizedBox(height: height * 0.12),
              Container(
                alignment: Alignment.center,
                child: ChicletOutlinedAnimatedButton(
                  buttonHeight: 2,
                  width: width * 0.9,
                  height: 70,
                  onPressed: () {
                    setState(() {
                      en = true;
                      fr = false;
                      ar = false;
                    });
                    widget.onLanguageChanged(const Locale('en'));
                    _savePreferences('en');
                  },
                  backgroundColor: !darkMode ? Colors.white : Colors.grey.shade900,
                  borderColor: en ? Color(0xff2E37A4) :darkMode? Color(0xff9196CC):Color(0xffEAEBF6),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 8,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/usa.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 75,
                        top: 20,
                        child: const AutoSizeText(
                          "English",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                alignment: Alignment.center,
                child: ChicletOutlinedAnimatedButton(
                  buttonHeight: 2,
                  width: width * 0.9,
                  height: 70,
                  backgroundColor: !darkMode ? Colors.white : Colors.grey.shade900,
                  borderColor: fr ? Color(0xff2E37A4) :darkMode? Color(0xff9196CC):Color(0xffEAEBF6),
                  onPressed: () {
                    setState(() {
                      en = false;
                      fr = true;
                      ar = false;
                    });
                    widget.onLanguageChanged(const Locale('fr'));
                    _savePreferences('fr');
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        left: 3,
                        top: 7,
                        child: Container(
                          margin: const EdgeInsets.only(left: 7),
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/french.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 75,
                        top: 20,
                        child: const AutoSizeText(
                          "Français",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                alignment: Alignment.center,
                child: ChicletOutlinedAnimatedButton(
                  buttonHeight: 2,
                  width: width * 0.9,
                  height: 70,
                  backgroundColor: !darkMode ? Colors.white : Colors.grey.shade900,
                  borderColor: ar ? Color(0xff2E37A4) :darkMode? Color(0xff9196CC):Color(0xffEAEBF6),
                  onPressed: () {
                    setState(() {
                      en = false;
                      fr = false;
                      ar = true;
                    });
                    widget.onLanguageChanged(const Locale('ar'));
                    _savePreferences('ar');
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Positioned(
                        right: 75,
                        top: 20,
                        child: const AutoSizeText(
                          "العربية",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 8,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/maroc.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.08),
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
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => const Accounttype()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
