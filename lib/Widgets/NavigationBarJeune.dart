import 'package:e_esg/pages/espacejeune/dossierMedical.dart';
import 'package:e_esg/pages/espacejeune/ies.dart';
import 'package:e_esg/pages/espacejeune/testpsy1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavbarYouth extends StatefulWidget {

  const NavbarYouth({super.key});
  static void setLocale(BuildContext context, Locale newLocale) async {
    _NavbarYouthState? state = context.findAncestorStateOfType<_NavbarYouthState>();
    state!.changeLanguage(newLocale);
  }
  @override
  State<NavbarYouth> createState() => _NavbarYouthState();
}

class _NavbarYouthState extends State<NavbarYouth> {
  List<dynamic> selected=[
    const Dossiermedical(),
    const Ies(),
    const Testpsy1(),
  ];

  static int _selectedItem = 0;

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

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  List<int> pile=[];
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
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
                        if(pile.contains(index)){
                          pile.remove(index);
                          pile.add(index);
                        }else{
                          pile.add(index);
                        }
                        print(selected.elementAt(index));
                        print(pile);
                        _selectedItem = index;
                      });
                    },
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    backgroundColor: isDarkMode ? const Color(0xff141218) : Colors.white,
                    items: [
                      BottomNavigationBarItem(
                        icon: _buildNavItem("assets/images/dossierMedical.png", "Dossier médical", 0,isDarkMode),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: _buildNavItem("assets/images/IES.png", "IES", 1,isDarkMode),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: _buildNavItem("assets/images/testPsych.png", "Test psychologique",2,isDarkMode),
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
  }
}
