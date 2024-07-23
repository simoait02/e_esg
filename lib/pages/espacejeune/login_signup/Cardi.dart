import 'package:shared_preferences/shared_preferences.dart';

import '../SideBar/Settings.dart';
import 'confirm_informations.dart';
import 'success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login.dart';
import 'SignUp.dart';
import 'Activitiesinformations.dart';
import 'Password.dart';

class CardiJeune extends StatefulWidget {
  static double q = 0.55;
  static double top = 0.25;
  static bool moveToActivitiesInformations = false;
  static bool stayinActivitiesInformations = false;
  static bool moveToPassword = false;
  static bool moveToConfirmInformations = false;
  static bool moveToSuccess = false;
  static TextEditingController lastnameController = TextEditingController();
  static TextEditingController firstnameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController numteleController = TextEditingController();
  static TextEditingController cneController = TextEditingController();
  static TextEditingController cinController = TextEditingController();
  static TextEditingController codemassarController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static String lastStud ="";
  static String stateActu="" ;
  static String studActu ="";
  static int value = 0;
  static int value1=0;
  static int age =0;
  static bool scolarity=false;
  static bool hasSelected=false;
  static DateTime? selectedDateTime ;
  static ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  CardiJeune({super.key});

  @override
  State<CardiJeune> createState() => _CardiJeuneState();
}

class _CardiJeuneState extends State<CardiJeune> {
  bool showLogin = true;




  void updateContainerSize(double newQ, double newTop) {
    setState(() {
      CardiJeune.q = newQ;
      CardiJeune.top = newTop;
    });
  }
  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      CardiJeune.isDarkMode.value = prefs.getBool('isDarkMode') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
      SettingsYong.isSystemSettings = prefs.getBool('isSystemSettings') ?? true;
      SettingsYong.isDark = prefs.getBool('isDark') ?? false;
      SettingsYong.isLight = prefs.getBool('isLight') ?? false;
    });
  }

  void toggleLoginSignUp() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  void navigateToActivitiesInformations() {
    setState(() {
      CardiJeune.moveToActivitiesInformations = true;
      CardiJeune.stayinActivitiesInformations = false;
      CardiJeune.moveToPassword = false;
      CardiJeune.moveToConfirmInformations=false;
      CardiJeune.moveToSuccess=false;
    });
  }
  void navigateToSuccess() {
    setState(() {
      CardiJeune.moveToActivitiesInformations = false;
      CardiJeune.stayinActivitiesInformations = false;
      CardiJeune.moveToPassword = false;
      CardiJeune.moveToConfirmInformations=false;
      CardiJeune.moveToSuccess=true;
    });
  }
  void navigateToConfirmInformations() {
    setState(() {
      CardiJeune.moveToActivitiesInformations = false;
      CardiJeune.stayinActivitiesInformations = false;
      CardiJeune.moveToPassword = false;
      CardiJeune.moveToConfirmInformations=true;
      CardiJeune.moveToSuccess=false;
    });
  }

  void stayInActivitiesInformations() {
    setState(() {
      CardiJeune.stayinActivitiesInformations = true;
      CardiJeune.moveToActivitiesInformations = false;
      CardiJeune.moveToPassword = false;
      CardiJeune.moveToConfirmInformations=false;
      CardiJeune.moveToSuccess=false;
    });
  }

  void navigateToPassword() {
    setState(() {
      CardiJeune.stayinActivitiesInformations = false;
      CardiJeune.moveToActivitiesInformations = false;
      CardiJeune.moveToPassword = true;
      CardiJeune.moveToConfirmInformations=false;
      CardiJeune.moveToSuccess=false;
    });
  }

  void navigateToSignup() {
    setState(() {
      showLogin = false;
      CardiJeune.stayinActivitiesInformations = false;
      CardiJeune.moveToActivitiesInformations = false;
      CardiJeune.moveToPassword = false;
      CardiJeune.moveToConfirmInformations=false;
      CardiJeune.moveToSuccess=false;
    });
  }

  void navigateToLogin() {
    setState(() {
      showLogin = true; // Ensure we are showing login screen
      CardiJeune.stayinActivitiesInformations = false;
      CardiJeune.moveToActivitiesInformations = false;
      CardiJeune.moveToPassword = false;
      CardiJeune.moveToConfirmInformations=false;
      CardiJeune.moveToSuccess=false;
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
            height: height * CardiJeune.q,
            decoration: BoxDecoration(
              color: CardiJeune.isDarkMode.value ? Color(0xff27272d) : Colors.white,
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
                  : CardiJeune.moveToActivitiesInformations ||
                  CardiJeune.stayinActivitiesInformations
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
                  : CardiJeune.moveToPassword
                  ? Password(
                onBackTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  stayInActivitiesInformations();
                  if(CardiJeune.hasSelected){
                    updateContainerSize(0.7, 0.1);
                    stayInActivitiesInformations();
                  }
                },
                onCreateTapped: (newQ,newTop){
                  updateContainerSize(newQ, newTop);
                  navigateToConfirmInformations();
                },

              )
                  : CardiJeune.moveToConfirmInformations
                  ? ConfirmInformations(
                onConfirmTapped: (newQ , newTop) {
                  updateContainerSize(newQ, newTop);
                  navigateToSuccess(); },
                onLoginTapped: (newQ , newTop ) { updateContainerSize(newQ, newTop);
              onLoginTapped(newQ, newTop); },
                )
                  : CardiJeune.moveToSuccess
                  ? Success()
                  : Signup(
                onSigninTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  toggleLoginSignUp();
                },
                onContinueTapped: () {
                  navigateToActivitiesInformations();
                  if(CardiJeune.hasSelected){
                    updateContainerSize(0.7, 0.1);
                    stayInActivitiesInformations();
                  }
                },
              ),
              ),
            ),
          ),
        ),
      );
  }
}
