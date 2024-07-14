import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/IES.dart';
import 'package:e_esg/pages/espaceMedecin/home/MesPatients/MesPatients.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Profile.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/TeleExpertise.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/espaceMedecin/home/Chatbot.dart';


class NavbarDoc extends StatefulWidget {
  const NavbarDoc({super.key});

  @override
  State<NavbarDoc> createState() => _NavbarDocState();
}

class _NavbarDocState extends State<NavbarDoc> {
  List<dynamic> selected = [
    const Mespatients(),
    const TeleExpertise(),
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
  }

  @override
  Widget build(BuildContext context) {
    Settings.isSystemSettings? Cardi.isDarkMode.value=(MediaQuery.of(context).platformBrightness == Brightness.dark):!Settings.isDark?Settings.isDark:Settings.isLight;
    return ValueListenableBuilder<bool>(
      valueListenable: Cardi.isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: Scaffold(
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: isDarkMode ? const Color(0x40ffffff) : const Color(0x3f000000),
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
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
                  backgroundColor: Cardi.isDarkMode.value?Color(0xff141218):Colors.white,
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
            body: selected[_selectedItem],
          ),
        );
      },
    );
  }
}
