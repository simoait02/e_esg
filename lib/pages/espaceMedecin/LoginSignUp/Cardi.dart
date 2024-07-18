import 'package:e_esg/pages/espaceMedecin/LoginSignUp/speciality.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import 'SignUp.dart';
import 'Password.dart';

class Cardi extends StatefulWidget {
  static double q = 0.5;
  static double top = 0.25;
  static bool moveToSpeciality = false;
  static bool stayinSpeciality = false;
  static bool moveToPassword = false;
  static ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);
  Cardi({super.key});

  @override
  State<Cardi> createState() => _CardiState();
}

class _CardiState extends State<Cardi> {
  bool showLogin = true;

  void updateContainerSize(double newQ, double newTop) {
    setState(() {
      Cardi.q = newQ;
      Cardi.top = newTop;
    });
  }

  void toggleLoginSignUp() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  void navigateToPassword() {
    setState(() {
      Cardi.moveToSpeciality = false;
      Cardi.stayinSpeciality = false;
      Cardi.moveToPassword = true;
    });
  }
  void navigateToSpeciality() {
    setState(() {
      Cardi.moveToSpeciality = true;
      Cardi.stayinSpeciality = false;
      Cardi.moveToPassword = false;
    });
  }
  void stayinSpeciality() {
    setState(() {
      Cardi.stayinSpeciality = true;
      Cardi.moveToSpeciality = false;
      Cardi.moveToPassword = false;
    });
  }

  void navigateToSignup() {
    setState(() {
      showLogin = false;
      Cardi.stayinSpeciality = false;
      Cardi.moveToSpeciality = false;
      Cardi.moveToPassword = false;
    });
  }
  void navigateToLogin() {
    setState(() {
      showLogin = true;
      Cardi.stayinSpeciality = false;
      Cardi.moveToSpeciality = false;
      Cardi.moveToPassword = false;
    });
  }
  void onLoginTapped(double newQ, double newTop) {
    updateContainerSize(newQ, newTop);
    toggleLoginSignUp();
    navigateToSpeciality();
  }
  @override
  void initState() {
    super.initState();
    _loadPreferences();
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Settings.isSystemSettings? Cardi.isDarkMode.value=(MediaQuery.of(context).platformBrightness == Brightness.dark):!Settings.isDark?Settings.isDark:Settings.isLight;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                color: Cardi.isDarkMode.value? Color(0xff27272d): Colors.white,
                border: Border.all(color: Color(0xFF2E37A4)),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(left: 20, right: 20,top: height*0.15,bottom: height*0.05),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: showLogin
                    ? Login(onSignUpTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  toggleLoginSignUp();
                })
                    : Cardi.moveToSpeciality ||
                    Cardi.stayinSpeciality
                    ? Speciality(
                  onBackTapped: (newQ, newTop) {
                    updateContainerSize(newQ, newTop);
                    navigateToSignup();
                  },
                  onSpecialityTapped: (newQ, newTop) {
                    updateContainerSize(newQ, newTop);
                    stayinSpeciality();
                  },
                  onPasswordTapped: (newQ, newTop) {
                    updateContainerSize(newQ, newTop);
                    navigateToPassword();
                  },
                )
                    : Cardi.moveToPassword
                    ? Password(
                  onBackTapped: (newQ, newTop) {
                    updateContainerSize(newQ, newTop);
                    stayinSpeciality();
                  },
                ):
                Signup(
                    onSigninTapped: (newQ, newTop) {
                      updateContainerSize(newQ, newTop);
                      toggleLoginSignUp();
                    },
                    onContinueTapped: () {
                      navigateToSpeciality();
                    }),
              ),
            ),
          ),
        ),
      );
  }
}
