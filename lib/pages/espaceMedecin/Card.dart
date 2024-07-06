import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login.dart';
import 'SignUp.dart';
import 'Password.dart';

class Cardi extends StatefulWidget {
  static double q = 0.45;
  static double top = 0.25;
  static bool isContinueTapped = false;

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
      Cardi.isContinueTapped = true;
    });
  }

  void navigateToSignup() {
    setState(() {
      Cardi.isContinueTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundLogin.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: width * 0.9,
              height: 1050 * Cardi.q,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(left: 20, right: 20, top: height * Cardi.top),
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: showLogin
                    ? Login(onSignUpTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  toggleLoginSignUp();
                })
                    : Cardi.isContinueTapped
                    ? Password(onBackTapped: (newQ,newTop) {
                  updateContainerSize(newQ, newTop);
                  navigateToSignup();
                })
                    : Signup(
                    onSigninTapped: (newQ, newTop) {
                      updateContainerSize(newQ, newTop);
                      toggleLoginSignUp();
                    },
                    onContinueTapped: () {
                      navigateToPassword();
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
