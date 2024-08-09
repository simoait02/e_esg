import 'package:e_esg/pages/espaceInfermier/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceInfermier/home/IES.dart';
import 'package:e_esg/pages/espaceInfermier/home/MesPatients/MesPatients.dart';
import 'package:e_esg/pages/espaceInfermier/home/Profile/Profile.dart';
import 'package:e_esg/pages/espaceInfermier/home/Profile/Settings.dart';
import 'package:e_esg/pages/espaceInfermier/home/teleExpertise/newTeleExpertise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../pages/espaceInfermier/home/chatbot.dart';

class Navigationbarpro extends StatefulWidget {
  const Navigationbarpro({super.key});
  static void setLocale(BuildContext context, Locale newLocale) async {
    _NavigationbarproState? state = context.findAncestorStateOfType<_NavigationbarproState>();
    state!.changeLanguage(newLocale);
  }
  @override
  State<Navigationbarpro> createState() => _NavigationbarproState();
}

class _NavigationbarproState extends State<Navigationbarpro> {
  List<dynamic> selected = [
    const Mespatients(),
    const Newteleexpertise(),
    const Ies(),
    const Chatbot(),
    const Profile(),
  ];

  int _selectedItem = 0;

  Widget _buildNavItem(String assetPath, String label, int index, bool isDarkMode) {
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 30,
              width: 30,
              color: _selectedItem == index
                  ? isDarkMode
                  ? const Color(0xff759cd8)
                  : const Color(0xff2e37a4)
                  : !isDarkMode
                  ? const Color(0x7f2e37a4)
                  : const Color(0x7f759cd8),
            ),
            if (_selectedItem == index)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 2, right: 2),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: !isDarkMode ? const Color(0xff2e37a4) : const Color(0xff759cd8),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  late String language;
  Locale? _locale;

  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      CardiInf.isDarkMode.value = prefs.getBool('isDarkModePro') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
      SettingsPro.isSystemSettings = prefs.getBool('isSystemSettingsPro') ?? true;
      SettingsPro.isDark = prefs.getBool('isDarkPro') ?? false;
      SettingsPro.isLight = prefs.getBool('isLightPro') ?? false;
      language = prefs.getString("languagePro") ?? 'en';
      _locale = Locale(language);
    });
  }
  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    SettingsPro.isSystemSettings
        ? CardiInf.isDarkMode.value = (MediaQuery.of(context).platformBrightness == Brightness.dark)
        : !SettingsPro.isDark
        ? SettingsPro.isDark
        : SettingsPro.isLight;
    return ValueListenableBuilder<bool>(
      valueListenable: CardiInf.isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          locale: _locale,
          supportedLocales: const [
            Locale('ar'),
            Locale('fr'),
            Locale('en')
          ],
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                selected[_selectedItem],
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xff141218) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: BottomNavigationBar(
                        currentIndex: _selectedItem,
                        onTap: (index) {
                          setState(() {
                            _selectedItem = index;
                          });
                        },
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        backgroundColor: isDarkMode ? const Color(0xff141218) : Colors.white,
                        items: [
                          BottomNavigationBarItem(
                            icon: _buildNavItem(
                              "assets/images/patients.png",
                              "Mes Patients",
                              0,
                              isDarkMode,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: _buildNavItem(
                              "assets/images/teleExpertise.png",
                              "Télé-\nExpertise",
                              1,
                              isDarkMode,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: _buildNavItem(
                              "assets/images/IES.png",
                              "IES",
                              2,
                              isDarkMode,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: _buildNavItem(
                              "assets/images/chatbot.png",
                              "Chatbot",
                              3,
                              isDarkMode,
                            ),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: _buildNavItem(
                              "assets/images/profile.png",
                              "Profile",
                              4,
                              isDarkMode,
                            ),
                            label: "",
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
      },
    );
  }
}
