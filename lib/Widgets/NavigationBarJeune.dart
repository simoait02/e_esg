import 'package:e_esg/pages/espacejeune/dossierMedical.dart';
import 'package:e_esg/pages/espacejeune/ies.dart';
import 'package:e_esg/pages/espacejeune/testpsy5.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../pages/IES/lives.dart';
import '../pages/espacejeune/testpsy1.dart';

void main() {
  runApp(const NavbarYouth());
}

class NavbarYouth extends StatefulWidget {
  const NavbarYouth({super.key});

  @override
  State<NavbarYouth> createState() => _NavbarYouthState();
}

class _NavbarYouthState extends State<NavbarYouth> {
  List<dynamic> selected = [
    const Dossiermedical(),
    const Ies(),
    const Testpsy1(),
  ];

  int _selectedItem = 0;

  Widget _buildNavItem(String assetPath, String label, int index) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
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
                  ? (isDarkMode
                  ? const Color(0xff759cd8)
                  : const Color(0xff2e37a4))
                  : (isDarkMode
                  ? const Color(0x7f759cd8)
                  : const Color(0x7f2e37a4)),
            ),
            if (_selectedItem == index)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, left: 2, right: 2),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: !isDarkMode
                          ? const Color(0xff2e37a4)
                          : const Color(0xff759cd8),
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
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                width: 1,
                color: isDarkMode
                    ? const Color(0x40ffffff)
                    : const Color(0x3f000000),
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
              backgroundColor: Colors.white,
              currentIndex: _selectedItem,
              onTap: (index) {
                setState(() {
                  _selectedItem = index;
                });
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: const Color(0xff2e37a4),
              unselectedItemColor: const Color(0x7f2e37a4),
              items: [
                BottomNavigationBarItem(
                  icon: _buildNavItem(
                      "assets/images/dossierMedical.png", "Dossier médical", 0),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: _buildNavItem("assets/images/IES.png", "IES", 1),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: _buildNavItem(
                      "assets/images/testPsych.png", "Test psychologique", 2),
                  label: "",
                ),
              ],
            ),
          ),
        ),
        body: selected[_selectedItem],
      ),
    );
  }
}
