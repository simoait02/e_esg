import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LanguageYouth.dart';

class SettingsYong extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;
  static bool themePressed = false;
  static bool isSystemSettings = true;
  static bool isDark = false;
  static bool isLight = false;
  static ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  const SettingsYong({
    super.key,
    required this.isSideBarClosed,
    required this.onSidebarToggle,
  });

  @override
  State<SettingsYong> createState() => _SettingsYongState();
}

class _SettingsYongState extends State<SettingsYong> with WidgetsBindingObserver {
  Color backgroundColor = SettingsYong.isDarkMode.value ? const Color(0xff181a1b) : Colors.white;
  Color textColor = SettingsYong.isDarkMode.value ? Colors.white : Colors.black;
  Color dividerColor = SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2);
  Color iconColor = SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (SettingsYong.isSystemSettings) {
      setState(() {
        SettingsYong.isDarkMode.value = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
        _updateColors();
      });
    }
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      SettingsYong.themePressed = prefs.getBool('themePressedYong') ?? false;
      SettingsYong.isSystemSettings = prefs.getBool('isSystemSettingsYong') ?? true;
      SettingsYong.isDark = prefs.getBool('isDarkYong') ?? false;
      SettingsYong.isLight = prefs.getBool('isLightYong') ?? false;
      SettingsYong.isDarkMode.value = prefs.getBool('isDarkModeYong') ?? (WidgetsBinding.instance.window.platformBrightness == Brightness.dark);
      _updateColors();
    });
  }

  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('themePressedYong', SettingsYong.themePressed);
    prefs.setBool('isSystemSettingsYong', SettingsYong.isSystemSettings);
    prefs.setBool('isDarkYong', SettingsYong.isDark);
    prefs.setBool('isLightYong', SettingsYong.isLight);
    prefs.setBool('isDarkModeYong', SettingsYong.isDarkMode.value);
  }

  _updateColors() {
    setState(() {
      backgroundColor = SettingsYong.isDarkMode.value ? const Color(0xff181a1b) : Colors.white;
      textColor = SettingsYong.isDarkMode.value ? Colors.white : Colors.black;
      dividerColor = SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2);
      iconColor = SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: SliverAppBar(
              automaticallyImplyLeading: true,
              floating: true,
              snap: true,
              backgroundColor: backgroundColor,
              leading: Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: widget.onSidebarToggle,
                  child: widget.isSideBarClosed
                      ? SvgPicture.asset('assets/images/more.svg')
                      : Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                        color: Color(0x5e0e1462), shape: BoxShape.circle),
                    child: const Icon(CupertinoIcons.clear,
                        color: Color(0xff2e37a4)),
                  ),
                ),
              ),
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.18),
                child: Text(
                  appLocalizations!.settings,
                  style: TextStyle(
                      color: SettingsYong.isDarkMode.value ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => Languageyouth()));
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
                                SettingsYong.themePressed = !SettingsYong.themePressed;
                                _savePreferences();
                              });
                            },
                            icon: Icon(
                              SettingsYong.themePressed
                                  ? CupertinoIcons.chevron_up
                                  : CupertinoIcons.chevron_down,
                              color: iconColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SettingsYong.themePressed
                      ? Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      children: [
                        Divider(
                          color: dividerColor,
                          thickness: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              SettingsYong.isDarkMode.value =
                                  WidgetsBinding.instance.window.platformBrightness ==
                                      Brightness.dark;
                              SettingsYong.isSystemSettings = true;
                              SettingsYong.isDark = false;
                              SettingsYong.isLight = false;
                              _savePreferences();
                              _updateColors();
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
                              SettingsYong.isSystemSettings
                                  ? Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.check,
                                    color: iconColor,
                                  ))
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
                              SettingsYong.isDarkMode.value = true;
                              SettingsYong.isDark = true;
                              SettingsYong.isLight = false;
                              SettingsYong.isSystemSettings = false;
                              _savePreferences();
                              _updateColors();
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
                              SettingsYong.isDark
                                  ? Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.check,
                                    color: iconColor,
                                  ))
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
                              SettingsYong.isDarkMode.value = false;
                              SettingsYong.isLight = true;
                              SettingsYong.isSystemSettings = false;
                              SettingsYong.isDark = false;
                              _savePreferences();
                              _updateColors();
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
                              SettingsYong.isLight
                                  ? Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.check,
                                    color: iconColor,
                                  ))
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
