import 'package:e_esg/pages/espaceMedecin/home/Chatbot.dart';
import 'package:e_esg/pages/espaceMedecin/home/IES.dart';
import 'package:e_esg/pages/espaceMedecin/home/MesPatients.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/TeleExpertise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
void main() {
  runApp(const Navbar());
}

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  List<dynamic> selected=[
    Mespatients(),
    TeleExpertise(),
    Ies(),
    Chatbot(),
    Profile()
  ];
  int _selectedItem = 0;
  Widget _buildNavItem(String assetPath, String label, int index) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SizedBox(
      child: Container(
        margin: const EdgeInsets.only(left: 5,right: 5),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(assetPath, height: 30, width: 30,
              color:_selectedItem==index?
              isDarkMode? Color(0xff759cd8) :Color(0xff2e37a4)
                  : !isDarkMode? Color(0x7f2e37a4) : Color(0x7f759cd8),),
            if (_selectedItem == index)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0,left: 2,right: 2),
                  child: Text(
                    label,
                    style:  TextStyle(color: !isDarkMode? Color(0xff2e37a4): Color(0xff759cd8), fontSize: 12),
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
                border: Border(top: BorderSide(width: 1, color: isDarkMode?Color(0x40ffffff): Color(0x3f000000))),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedItem,
                onTap: (index){
                  setState(() {
                    _selectedItem=index;
                  });
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: _buildNavItem("assets/images/patients.png", "Mes Patients", 0),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavItem("assets/images/teleExpertise.png", "Télé-\nExpertise", 1),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavItem("assets/images/IES.png", "IES", 2),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavItem("assets/images/chatbot.png", "Chatbot", 3),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildNavItem("assets/images/profile.png", "Profile", 4),
                    label: "",
                  ),
                ],
              ),
            ),
          ),
          body: selected[_selectedItem]
      ),
    );
  }
}
