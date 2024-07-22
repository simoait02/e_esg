import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Login.dart';
import 'SignUp.dart';
import 'Password.dart';

class CardiInf extends StatefulWidget {
  static double q = 0.5;
  static double top = 0.25;
  static bool isContinueTapped = false;
  static TextEditingController nomController = TextEditingController();
  static TextEditingController prenomController = TextEditingController();
  static TextEditingController cinController = TextEditingController();
  static TextEditingController inpeController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController numTeleController = TextEditingController();
  static ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(true);
  CardiInf({super.key});

  @override
  State<CardiInf> createState() => _CardiInfState();
}

class _CardiInfState extends State<CardiInf> {
  bool showLogin = true;

  void updateContainerSize(double newQ, double newTop) {
    setState(() {
      CardiInf.q = newQ;
      CardiInf.top = newTop;
    });
  }

  void toggleLoginSignUp() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  void navigateToPassword() {
    setState(() {
      CardiInf.isContinueTapped = true;
    });
  }

  void navigateToSignup() {
    setState(() {
      CardiInf.isContinueTapped = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    CardiInf.isDarkMode.value=(MediaQuery.of(context).platformBrightness == Brightness.dark);
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
              height: height * CardiInf.q,
              decoration: BoxDecoration(
                color: CardiInf.isDarkMode.value? Color(0xff27272d): Colors.white,
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
                    : CardiInf.isContinueTapped
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
      );
  }
}
