import 'package:e_esg/pages/espaceInfermier/LoginSignUp/reset_pasword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Login.dart';
import 'Password.dart';
import 'new_password.dart';
import 'package:e_esg/pages/espaceInfermier/LoginSignUp/SignUp.dart';
class CardiInf extends StatefulWidget {
  static double q = 0.55;
  static double top = 0.25;
  static ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(true);
  static TextEditingController nomController = TextEditingController();
  static TextEditingController prenomController = TextEditingController();
  static TextEditingController cinController = TextEditingController();
  static TextEditingController inpeController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController numTeleController = TextEditingController();

  CardiInf({Key? key}) : super(key: key);

  @override
  _CardiInfState createState() => _CardiInfState();
}

class _CardiInfState extends State<CardiInf> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    CardiInf.q=0.55;
    CardiInf.top=0.25;
    super.initState();
    _pages = _initializePages();
  }

  List<Widget> _initializePages() {
    return [
      Login(
        onSignUpTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(1);
        },
        onResetPassTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(2);
        },
      ),
      Signup(
        onSigninTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(0);
        },
        onContinueTapped: () {
          navigateTo(3);
        },
      ),
      ResetPassword(
        onBackTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(0);
        },
        onContinueTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(4);
        },
      ),
      Password(
        onBackTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(1);
        },onConfirmTapped: (newQ, newTop) {
        updateContainerSize(newQ, newTop);
        navigateTo(0);
      },
      ),
      NewPassword(
        onBackTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(2);
        },
        onValidTapped: (newQ, newTop) {
          updateContainerSize(newQ, newTop);
          navigateTo(0);
        },
      ),
    ];
  }

  void updateContainerSize(double newQ, double newTop) {
    setState(() {
      CardiInf.q = newQ;
      CardiInf.top = newTop;
    });
  }

  void navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    CardiInf.isDarkMode.value =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
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
              color: CardiInf.isDarkMode.value ? const Color(0xff27272d) : Colors.white,
              border: Border.all(color: const Color(0xFF2E37A4)),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.only(
                left: 20, right: 20, top: height * 0.15, bottom: height * 0.05),
            child: _pages[_currentIndex],
          ),
        ),
      ),
    );
  }
}
