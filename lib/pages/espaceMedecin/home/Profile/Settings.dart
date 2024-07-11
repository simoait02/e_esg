import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool themePressed = false;
  bool isSystemSettings = true;
  bool isDark = false;
  bool isLight = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      themePressed = prefs.getBool('themePressed') ?? false;
      isSystemSettings = prefs.getBool('isSystemSettings') ?? true;
      isDark = prefs.getBool('isDark') ?? false;
      isLight = prefs.getBool('isLight') ?? false;
      Cardi.isDarkMode.value = prefs.getBool('isDarkMode') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
  }

  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('themePressed', themePressed);
    prefs.setBool('isSystemSettings', isSystemSettings);
    prefs.setBool('isDark', isDark);
    prefs.setBool('isLight', isLight);
    prefs.setBool('isDarkMode', Cardi.isDarkMode.value);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color backgroundColor = Cardi.isDarkMode.value ? const Color(0xff181a1b) : Colors.white;
    Color textColor = Cardi.isDarkMode.value ? Colors.white : Colors.black;
    Color dividerColor = Cardi.isDarkMode.value ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2);
    Color iconColor = Cardi.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: backgroundColor,
        previousPageTitle: "Back",
        middle: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.settings_16_regular, color: textColor),
              SizedBox(width: 8),
              Text(
                "Settings",
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
            _savePreferences(); // Save preferences when done
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
            Row(
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
                AutoSizeText(
                  "Language",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                ),
              ],
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
                  "Theme",
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
                          themePressed = !themePressed;
                          _savePreferences(); // Save preferences when theme is pressed
                        });
                      },
                      icon: Icon(
                        themePressed
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                        color: iconColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            themePressed
                ? Container(
              padding: EdgeInsets.only(left: width * 0.1),
              child: Column(
                children: [
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
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            Cardi.isDarkMode.value = MediaQuery.of(context).platformBrightness == Brightness.dark;
                            isSystemSettings = true;
                            isDark = false;
                            isLight = false;
                            _savePreferences(); // Save preferences when system settings is selected
                          });
                        },
                        child: AutoSizeText(
                          "System settings",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      isSystemSettings
                          ? Expanded(
                        child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Icon(Icons.check, color: iconColor,)
                        ),
                      )
                          : Container(),
                    ],
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
                          "assets/images/darkMode.png",
                          color: iconColor,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Cardi.isDarkMode.value = true;
                            isDark = true;
                            isLight = false;
                            isSystemSettings = false;
                            _savePreferences(); // Save preferences when dark mode is selected
                          });
                        },
                        child: AutoSizeText(
                          "Dark mode",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      isDark
                          ? Expanded(
                        child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Icon(Icons.check, color: iconColor,)
                        ),
                      )
                          : Container(),
                    ],
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
                          "assets/images/lightMode.png",
                          color: iconColor,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Cardi.isDarkMode.value = false;
                            isLight = true;
                            isSystemSettings = false;
                            isDark = false;
                            _savePreferences(); // Save preferences when light mode is selected
                          });
                        },
                        child: AutoSizeText(
                          "Light mode",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      isLight
                          ? Expanded(
                        child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Icon(Icons.check, color: iconColor,)
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ],
              ),
            )
                : Container(),
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
                    "assets/images/infos.png",
                    color: iconColor,
                  ),
                ),
                SizedBox(width: width * 0.02),
                AutoSizeText(
                  "Mes informations",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                ),
              ],
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
                  "Log out",
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
