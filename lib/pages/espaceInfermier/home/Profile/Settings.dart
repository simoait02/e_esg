import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceInfermier/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceInfermier/home/Profile/InfosPersonal.dart';
import 'package:e_esg/pages/espaceInfermier/home/Profile/Language.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPro extends StatefulWidget {
  static bool themePressed = false;
  static bool isSystemSettings = true;
  static bool isDark = false;
  static bool isLight = false;
  const SettingsPro({super.key});

  @override
  State<SettingsPro> createState() => _SettingsProState();
}

class _SettingsProState extends State<SettingsPro> {

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      SettingsPro.themePressed = prefs.getBool('themePressedPro') ?? false;
      SettingsPro.isSystemSettings = prefs.getBool('isSystemSettingsPro') ?? true;
      SettingsPro.isDark = prefs.getBool('isDarkPro') ?? false;
      SettingsPro.isLight = prefs.getBool('isLightPro') ?? false;
      CardiInf.isDarkMode.value = prefs.getBool('isDarkModePro') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
  }

  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('themePressedPro', SettingsPro.themePressed);
    prefs.setBool('isSystemSettingsPro', SettingsPro.isSystemSettings);
    prefs.setBool('isDarkPro', SettingsPro.isDark);
    prefs.setBool('isLightPro', SettingsPro.isLight);
    prefs.setBool('isDarkModePro', CardiInf.isDarkMode.value);
  }

  @override
  Widget build(BuildContext context) {
    SettingsPro.isSystemSettings? CardiInf.isDarkMode.value=(MediaQuery.of(context).platformBrightness == Brightness.dark):SettingsPro.isDark?SettingsPro.isDark:SettingsPro.isLight;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color backgroundColor = CardiInf.isDarkMode.value ? const Color(0xff181a1b) : Colors.white;
    Color textColor = CardiInf.isDarkMode.value ? Colors.white : Colors.black;
    Color dividerColor = CardiInf.isDarkMode.value ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2);
    Color iconColor = CardiInf.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5);
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: backgroundColor,
        previousPageTitle: appLocalizations!.precedent,
        middle: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.settings_16_regular, color: textColor),
              SizedBox(width: 8),
              Text(
                appLocalizations.settings,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            _savePreferences();
            Navigator.pop(context);
          },
          child: Text(
            "Done",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: backgroundColor,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            GestureDetector(
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>Language()));
              },
              child: Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: Image.asset(
                      "assets/images/language.png",
                      color: iconColor,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: AutoSizeText(
                      appLocalizations.language,
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: dividerColor,
              thickness: 1,
            ),
            Row(
              children: [
                SizedBox(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    "assets/images/theme.png",
                    color: iconColor,
                  ),
                ),
                SizedBox(width: width * 0.02),
                AutoSizeText(
                  appLocalizations.appearance,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          SettingsPro.themePressed = !SettingsPro.themePressed;
                          _savePreferences();
                        });
                      },
                      icon: Icon(
                        SettingsPro.themePressed
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                        color: iconColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SettingsPro.themePressed
                ? Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Column(
                children: [
                  Divider(
                    color: dividerColor,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        CardiInf.isDarkMode.value = MediaQuery.of(context).platformBrightness == Brightness.dark;
                        SettingsPro.isSystemSettings = true;
                        SettingsPro.isDark = false;
                        SettingsPro.isLight = false;
                        _savePreferences();
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/theme.png",
                            color: iconColor,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                          Expanded(
                            child: AutoSizeText(
                              appLocalizations.systemSettings,
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                  fontSize: 22,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        SettingsPro.isSystemSettings
                            ? Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(Icons.check, color: iconColor,)
                        )
                            : Container(),
                      ],
                    ),
                  ),
                  Divider(
                    color: dividerColor,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        CardiInf.isDarkMode.value = true;
                        SettingsPro.isDark = true;
                        SettingsPro.isLight = false;
                        SettingsPro.isSystemSettings = false;
                        _savePreferences();
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/darkMode.png",
                            color: iconColor,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: AutoSizeText(
                            appLocalizations.dark,
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                fontSize: 22,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                        SettingsPro.isDark
                            ? Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(Icons.check, color: iconColor,)
                        )
                            : Container(),
                      ],
                    ),
                  ),
                  Divider(
                    color: dividerColor,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        CardiInf.isDarkMode.value = false;
                        SettingsPro.isLight = true;
                        SettingsPro.isSystemSettings = false;
                        SettingsPro.isDark = false;
                        _savePreferences();
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/lightMode.png",
                            color: iconColor,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: AutoSizeText(
                              appLocalizations.light,
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                  fontSize: 22,
                                  color: textColor,
                                ),
                              ),
                            ),
                        ),
                        SettingsPro.isLight
                            ? Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(Icons.check, color: iconColor,)
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            )
                : Container(),
            Divider(
              color: dividerColor,
              thickness: 1,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>Infospersonal()));
              },
              child: Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: Image.asset(
                      "assets/images/infos.png",
                      color: iconColor,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Expanded(
                    child: AutoSizeText(
                      appLocalizations.myInfos,
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          fontSize: 22,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: dividerColor,
              thickness: 1,
            ),
            Row(
              children: [
                SizedBox(
                  height: 35,
                  width: 35,
                  child: Image.asset(
                    "assets/images/logOut.png",
                    color: iconColor,
                  ),
                ),
                SizedBox(width: width * 0.02),
                AutoSizeText(
                  appLocalizations.logOut,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
