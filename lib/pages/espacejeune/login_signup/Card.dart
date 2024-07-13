import 'confirm_informations.dart';
import 'success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login.dart';
import 'SignUp.dart';
import 'Activitiesinformations.dart';
import 'Password.dart';

class Cardi extends StatefulWidget {
  static double q = 0.6;
  static double top = 0.25;
  static bool moveToActivitiesInformations = false;
  static bool stayinActivitiesInformations = false;
  static bool moveToPassword = false;
  static bool moveToConfirmInformations = false;
  static bool moveToSuccess = false;

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

  void navigateToActivitiesInformations() {
    setState(() {
      Cardi.moveToActivitiesInformations = true;
      Cardi.stayinActivitiesInformations = false;
      Cardi.moveToPassword = false;
      Cardi.moveToConfirmInformations=false;
      Cardi.moveToSuccess=false;
    });
  }
  void navigateToSuccess() {
    setState(() {
      Cardi.moveToActivitiesInformations = false;
      Cardi.stayinActivitiesInformations = false;
      Cardi.moveToPassword = false;
      Cardi.moveToConfirmInformations=false;
      Cardi.moveToSuccess=true;
    });
  }
  void navigateToConfirmInformations() {
    setState(() {
      Cardi.moveToActivitiesInformations = false;
      Cardi.stayinActivitiesInformations = false;
      Cardi.moveToPassword = false;
      Cardi.moveToConfirmInformations=true;
      Cardi.moveToSuccess=false;
    });
  }

  void stayInActivitiesInformations() {
    setState(() {
      Cardi.stayinActivitiesInformations = true;
      Cardi.moveToActivitiesInformations = false;
      Cardi.moveToPassword = false;
      Cardi.moveToConfirmInformations=false;
      Cardi.moveToSuccess=false;
    });
  }

  void navigateToPassword() {
    setState(() {
      Cardi.stayinActivitiesInformations = false;
      Cardi.moveToActivitiesInformations = false;
      Cardi.moveToPassword = true;
      Cardi.moveToConfirmInformations=false;
      Cardi.moveToSuccess=false;
    });
  }

  void navigateToSignup() {
    setState(() {
      showLogin = false; // Ensure we are showing signup screen
      Cardi.stayinActivitiesInformations = false;
      Cardi.moveToActivitiesInformations = false;
      Cardi.moveToPassword = false;
      Cardi.moveToConfirmInformations=false;
      Cardi.moveToSuccess=false;
    });
  }

  void navigateToLogin() {
    setState(() {
      showLogin = true; // Ensure we are showing login screen
      Cardi.stayinActivitiesInformations = false;
      Cardi.moveToActivitiesInformations = false;
      Cardi.moveToPassword = false;
      Cardi.moveToConfirmInformations=false;
      Cardi.moveToSuccess=false;
    });
  }

  void onLoginTapped(double newQ, double newTop) {
    updateContainerSize(newQ, newTop);
    toggleLoginSignUp();
    navigateToActivitiesInformations();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
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
              color: isDarkMode ? Color(0xff27272d) : Colors.white,
              border: Border.all(color: Color(0xFF2E37A4)),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: height * 0.15,
              bottom: height * 0.05,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: showLogin
                  ? Login(
                onSignUpTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  navigateToSignup();
                },
              )
                  : Cardi.moveToActivitiesInformations ||
                  Cardi.stayinActivitiesInformations
                  ? Activitiesinformations(
                onBackTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  navigateToSignup();
                },
                onScolarityTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  stayInActivitiesInformations();
                },
                onPasswordTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  navigateToPassword();
                },
                onLoginTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  onLoginTapped(newQ, newTop);
                },
              )
                  : Cardi.moveToPassword
                  ? Password(
                onBackTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  stayInActivitiesInformations();
                },
                onCreateTapped: (newQ,newTop){
                  updateContainerSize(newQ, newTop);
                  navigateToConfirmInformations();
                },
              )
                  : Cardi.moveToConfirmInformations
                  ? ConfirmInformations(
                onConfirmTapped: (newQ , newTop) {
                  updateContainerSize(newQ, newTop);
                  navigateToSuccess(); },
                onLoginTapped: (newQ , newTop ) { updateContainerSize(newQ, newTop);
              onLoginTapped(newQ, newTop); },)
                  : Cardi.moveToSuccess
                  ? Success()
                  : Signup(
                onSigninTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  toggleLoginSignUp();
                },
                onContinueTapped: () {
                  navigateToActivitiesInformations();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
