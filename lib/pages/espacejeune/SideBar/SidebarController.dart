import 'dart:math';
import 'package:e_esg/Widgets/NavigationBarJeune.dart';
import 'package:e_esg/pages/espacejeune/SideBar/Settings.dart';
import 'package:e_esg/pages/espacejeune/gamification/widgets/game_app.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SideBarYong.dart';

class SideBarController extends StatefulWidget {
  const SideBarController({super.key});
  static void setLocale(BuildContext context, Locale newLocale) async {
    _SideBarControllerState? state = context.findAncestorStateOfType<_SideBarControllerState>();
    state!.changeLanguage(newLocale);
  }
  @override
  State<SideBarController> createState() => _SideBarControllerState();
}

class _SideBarControllerState extends State<SideBarController> with SingleTickerProviderStateMixin {
  bool isSideBarClosed = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  int selectedItem = 1;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
      setState(() {});
    });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    _loadPreferences();
    super.initState();
  }
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = prefs.getString("languageYong") ?? 'fr';
      _locale = Locale(language);
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSidebarItemSelected(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  Widget _getSelectedWidget() {
    switch (selectedItem) {
      case 1:
        return NavbarYouth(
          isSideBarClosed: isSideBarClosed,
          onSidebarToggle: () {
          if (isSideBarClosed) {
          _animationController.forward();
          } else {
          _animationController.reverse();
          }
          setState(() {
          isSideBarClosed = !isSideBarClosed;
          });
          },
        );
      case 2: return GameApp(isSideBarClosed: isSideBarClosed,
        onSidebarToggle: () {
          if (isSideBarClosed) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
          setState(() {
            isSideBarClosed = !isSideBarClosed;
          });
        },);
        // // return Discussions(
        //   isSideBarClosed: isSideBarClosed,
        //   onSidebarToggle: () {
        //     if (isSideBarClosed) {
        //       _animationController.forward();
        //     } else {
        //       _animationController.reverse();
        //     }
        //     setState(() {
        //       isSideBarClosed = !isSideBarClosed;
        //     });
        //   },
        // );
      case 3:
        return SettingsYong(isSideBarClosed: isSideBarClosed,
          onSidebarToggle: () {
            if (isSideBarClosed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            setState(() {
              isSideBarClosed = !isSideBarClosed;
            });
          },
        );
      default:
        return Container();
    }
  }
  late String language;
  Locale? _locale;
  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
      home: Scaffold(
        backgroundColor: const Color(0xff2e37a4),
        // body: GestureDetector(
        //       onHorizontalDragEnd: (details) {
        //     if (details.primaryVelocity! > 0 && isSideBarClosed) {
        //       _animationController.forward();
        //       setState(() {
        //         isSideBarClosed = !isSideBarClosed;
        //       });
        //     } else if (details.primaryVelocity! < 0 && !isSideBarClosed) {
        //       _animationController.reverse();
        //       setState(() {
        //         isSideBarClosed = !isSideBarClosed;
        //       });
        //     }
        //     },
        //   child:
        body :Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                width: width * 0.75,
                left: isSideBarClosed ? -width * 0.75 : 0,
                height: height,
                child: SidebarYong(
                  selectedItem: selectedItem,
                  onItemSelected: _onSidebarItemSelected,
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(animation.value - 30 * animation.value * pi / 180),
                child: Transform.translate(
                  offset: Offset(animation.value * width * 0.7, 0),
                  child: Transform.scale(
                    scale: scaleAnimation.value,
                    child: ClipRRect(
                      borderRadius: isSideBarClosed ? BorderRadius.zero : BorderRadius.circular(24),
                      child: Container(
                        color: isDarkMode ? const Color(0xff141218) : Colors.white,
                        child: _getSelectedWidget(),
                      ),
                    ),
                  ),
                ),
              ),
              // AnimatedPositioned(
              //   duration: const Duration(milliseconds: 200),
              //   top:isSideBarClosed?height*0.04: height*0.132,
              //   left: isSideBarClosed? width*0.02: width*0.55,
              //   child: IconButton(
              //       onPressed: () {
              //         if (isSideBarClosed) {
              //           _animationController.forward();
              //         } else {
              //           _animationController.reverse();
              //         }
              //         setState(() {
              //           isSideBarClosed = !isSideBarClosed;
              //         });
              //       },
              //       icon: isSideBarClosed
              //           ? Container()
              //               : Container(
              //           height: 50,
              //           width: 50,
              //           decoration: const BoxDecoration(
              //           color: Color(0x5e0e1462),
              //           shape: BoxShape.circle),
              //           child: const Icon(CupertinoIcons.clear_circled_solid, color: Color(
              //               0xffeaebff),size: 50,),
              //           ),
              //   ),
              // )
            ],
          ),
        ),
      );
  }
}

