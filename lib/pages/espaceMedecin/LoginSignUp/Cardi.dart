import 'package:e_esg/pages/espaceMedecin/LoginSignUp/resetPassword.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/speciality.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import 'SignUp.dart';
import 'Password.dart';
import 'newPassword.dart';

class Cardi extends StatefulWidget {
  static double q = 0.55;
  static double top = 0.25;
  static bool moveToSpeciality = false;
  static bool stayinSpeciality = false;
  static bool moveToPassword = false;
  static bool moveToResetPass = false;
  static TextEditingController emailController = TextEditingController();
  static TextEditingController nomController = TextEditingController();
  static TextEditingController prenomController = TextEditingController();
  static TextEditingController cinController = TextEditingController();
  static TextEditingController inpeController = TextEditingController();
  static TextEditingController teleController = TextEditingController();
  static TextEditingController pprController = TextEditingController();
  static TextEditingController specialiteeController = TextEditingController();
  static bool isGeneralist = true;
  static bool isEsgDoctor = false;
  static ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  Cardi({super.key});

  @override
  State<Cardi> createState() => _CardiState();
}

class _CardiState extends State<Cardi> {
  bool showLogin = true;
  int currentScreenIndex = 0;

  void updateContainerSize(double newQ, double newTop) {
    setState(() {
      Cardi.q = newQ;
      Cardi.top = newTop;
    });
  }

  void navigateToScreen(int screenIndex) {
    setState(() {
      currentScreenIndex = screenIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Settings.isSystemSettings ? Cardi.isDarkMode.value = (MediaQuery.of(context).platformBrightness == Brightness.dark) : !Settings.isDark ? Settings.isDark : Settings.isLight;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final List<Widget> screens = [
      Login(
        onSignUpTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(1);
        },
        onRestPassTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(4);
        },
      ),
      Signup(
        onSigninTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(0);
        },
        onContinueTapped: () {
          navigateToScreen(2);
        },
      ),
      Speciality(
        onBackTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(1);
        },
        onSpecialityTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(2);
        },
        onPasswordTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(3);
        },
      ),
      Password(
        onBackTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(2);
        },
      ),
      Resetpassword(
        onBackTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(0);
        },
        onContinueTapped:(newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(5);}
      ),
      Newpassword(
        onBackTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(4);
        }, onValidTrapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateToScreen(0);},
      )
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: width * 0.9,
            height: height * Cardi.q,
            decoration: BoxDecoration(
              color: Cardi.isDarkMode.value ? Color(0xff27272d) : Colors.white,
              border: Border.all(color: Color(0xFF2E37A4)),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(left: 20, right: 20, top: height * 0.15, bottom: height * 0.05),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: screens[currentScreenIndex],
            ),
          ),
        ),
      ),
    );
  }
}
