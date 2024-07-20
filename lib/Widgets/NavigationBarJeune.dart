import 'package:e_esg/pages/espacejeune/dossierMedical.dart';
import 'package:e_esg/pages/espacejeune/ies.dart';
import 'package:e_esg/pages/espacejeune/testpsy1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

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
  bool isPlay=false;
  late AnimationController _controller;
  @override
  void initState() {
    _controller=AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
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
            ClipPath(
              clipper: CustomMenuClipper(),
              child: Container(
                width: 35,
                height: 100,
                color: Color(0xff2e37a4),
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: widget.onSidebarToggle,
                  child: widget.isSideBarClosed?Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: SvgPicture.asset(
                      "assets/images/more.svg",
                      color: Colors.purple.shade100,
                    ),
                  ):Icon(
                    CupertinoIcons.clear_circled_solid,size: 40,
                  ),
                )
              ),
            )
          ],
        ),
      ),
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