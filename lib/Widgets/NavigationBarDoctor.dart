import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/IES.dart';
import 'package:e_esg/pages/espaceMedecin/home/MesPatients/MesPatients.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Profile.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/newTeleExpertise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../pages/espaceMedecin/home/Chatbot.dart';

class NavbarDoc extends StatefulWidget {
  const NavbarDoc({super.key});

  @override
  State<NavbarDoc> createState() => _NavbarDocState();
}

class _NavbarDocState extends State<NavbarDoc> {
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
      Cardi.isDarkMode.value = prefs.getBool('isDarkMode') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
      Settings.isSystemSettings = prefs.getBool('isSystemSettings') ?? true;
      Settings.isDark = prefs.getBool('isDark') ?? false;
      Settings.isLight = prefs.getBool('isLight') ?? false;
      language = prefs.getString("language") ?? 'en';
      _locale = Locale(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    Settings.isSystemSettings
        ? Cardi.isDarkMode.value = (MediaQuery.of(context).platformBrightness == Brightness.dark)
        : !Settings.isDark
        ? Settings.isDark
        : Settings.isLight;
    return ValueListenableBuilder<bool>(
      valueListenable: Cardi.isDarkMode,
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
            body: Directionality(
              textDirection: TextDirection.ltr,
              child: Stack(
                children: [
                  selected[_selectedItem],
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkMode ? const Color(0xff141218) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
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
          ),
        );
      },
    );
  }
}
