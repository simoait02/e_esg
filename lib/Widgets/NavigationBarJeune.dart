import 'package:e_esg/pages/IES/espace_jeune.dart';
import 'package:e_esg/pages/espacejeune/SideBar/Settings.dart';
import 'package:e_esg/pages/espacejeune/dossierMedical.dart';
import 'package:e_esg/pages/espacejeune/ies.dart';
import 'package:e_esg/pages/espacejeune/testpsy1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_esg/pages/espacejeune/SideBar/Settings.dart';

class NavbarYouth extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;
  const NavbarYouth({super.key,required this.isSideBarClosed,
    required this.onSidebarToggle,});
  static void setLocale(BuildContext context, Locale newLocale) async {
    _NavbarYouthState? state = context.findAncestorStateOfType<_NavbarYouthState>();
    state!.changeLanguage(newLocale);
  }
  @override
  State<NavbarYouth> createState() => _NavbarYouthState();
}

class _NavbarYouthState extends State<NavbarYouth> with TickerProviderStateMixin{
  List<dynamic> selected=[
    const Dossiermedical(),
    const EspaceJeune(),
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
  bool isPlay=false;
  late AnimationController _controller;
  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration: const Duration(milliseconds: 200));
    _loadPreferences();
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  late String language;
  Locale? _locale;

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = prefs.getString("languageYong") ?? 'en';
      _locale = Locale(language);
      SettingsYong.themePressed = prefs.getBool('themePressedYong') ?? false;
      SettingsYong.isSystemSettings = prefs.getBool('isSystemSettingsYong') ?? true;
      SettingsYong.isDark = prefs.getBool('isDarkYong') ?? false;
      SettingsYong.isLight = prefs.getBool('isLightYong') ?? false;
      SettingsYong.isDarkMode.value = prefs.getBool('isDarkModeYong') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
  }
  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  List<int> pile=[];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: SettingsYong.isDarkMode,
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
            body: Stack(
              children: [
                GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0 && widget.isSideBarClosed) {
                      widget.onSidebarToggle(); // Ensure to call the function
                    } else if (details.primaryVelocity! < 0 && !widget.isSideBarClosed) {
                      widget.onSidebarToggle(); // Ensure to call the function
                    }
                  },
                  child: selected[_selectedItem],
                ),
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
                            if (pile.contains(index)) {
                              pile.remove(index);
                              pile.add(index);
                            } else {
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
                            icon: _buildNavItem("assets/images/dossierMedical.png", "Dossier médical", 0, isDarkMode),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: _buildNavItem("assets/images/IES.png", "IES", 1, isDarkMode),
                            label: "",
                          ),
                          BottomNavigationBarItem(
                            icon: _buildNavItem("assets/images/testPsych.png", "Test psychologique", 2, isDarkMode),
                            label: "",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 20,
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 100,
                      color: const Color(0xff2e37a4),
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: widget.onSidebarToggle,
                        child: widget.isSideBarClosed
                            ? Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SvgPicture.asset(
                            "assets/images/more.svg",
                            color: Colors.purple.shade100,
                          ),
                        )
                            : const Icon(
                          CupertinoIcons.clear_circled_solid,
                          size: 40,
                          color: Colors.white24,
                        ),
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
class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Paint paint=Paint();
    paint.color=Colors.white;
    final width=size.width;
    final height=size.height;
    Path path=Path();
    path.moveTo(0,0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2 -20, width, height/2);
    path.quadraticBezierTo(width+1, height/2 +20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}