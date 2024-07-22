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

  CardiJeune({super.key});

  @override
  State<CardiJeune> createState() => _CardiJeuneState();
}

class _CardiJeuneState extends State<CardiJeune> {
  bool showLogin = true;

  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numteleController = TextEditingController();
  final TextEditingController _cneController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _codemassarController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _lastStud ="";
  String _stateActu="" ;
  String _studActu ="";
  int _value = 0;
  int _value1=0;
  int _age =0;
  bool _scolarity=false;
  bool _hasSelected=false;
  DateTime _selectedDateTime=DateTime.now() ;
  void onFormChange(int value,int age, DateTime selectedDateTime, String lastname, String firstname, String email, String numtele) {
    setState(() {
      this._value = value;
      this._age=age;
      this._selectedDateTime = selectedDateTime;
      this._lastnameController.text=lastname;
      this._firstnameController.text=firstname;
      this._emailController.text=email;
      this._numteleController.text=numtele;

    });
  }
  void onFormChange1(int value, String cne, String cin, String codemassar, String lastStud,String stateActu,String studActu,bool scolarity,bool hasSelected) {
    setState(() {
      this._value1 = value;
      this._cneController.text = cne;
      this._cinController.text=cin;
      this._codemassarController.text=codemassar;
      this._lastStud=lastStud;
      this._stateActu=stateActu;
      this._studActu=studActu;
      this._scolarity=scolarity;
      this._hasSelected=hasSelected;

    });
  }
  void onFormChange2(String password){
    setState(() {
      this._passwordController.text=password;
    });
  }

  void updateContainerSize(double newQ, double newTop) {
    setState(() {
      CardiJeune.q = newQ;
      CardiJeune.top = newTop;
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
            height: height * CardiJeune.q,
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
                age:_age,
                value:_value1,
                cneController:_cneController,
                cinController:_cinController,
                codemassarController:_codemassarController,
                lastStud:_lastStud ,
                stateActu:_stateActu,
                studActu:_studActu,
                onFormChange:onFormChange1,
                scolarity: _scolarity,
                hasSelected: _hasSelected,

              )
                  : CardiJeune.moveToPassword
                  ? Password(
                onBackTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  stayInActivitiesInformations();
                  if(_hasSelected){
                    updateContainerSize(0.7, 0.1);
                    stayInActivitiesInformations();
                  }
                },
                onCreateTapped: (newQ,newTop){
                  updateContainerSize(newQ, newTop);
                  navigateToConfirmInformations();
                },
                passwordController: _passwordController,
                onFormChange: onFormChange2,

              )
                  : CardiJeune.moveToConfirmInformations
                  ? ConfirmInformations(
                onConfirmTapped: (newQ , newTop) {
                  updateContainerSize(newQ, newTop);
                  navigateToSuccess(); },
                onLoginTapped: (newQ , newTop ) { updateContainerSize(newQ, newTop);
              onLoginTapped(newQ, newTop); },
                scolarity: _scolarity, value: _value, age: _age, numtele: _numteleController.text, email: _emailController.text, firstname: _firstnameController.text, lastname: _lastnameController.text,lastStud: _lastStud,stateActu: _stateActu,cin: _cinController.text,cne: _cneController.text,codemassar: _codemassarController.text,studActu: _studActu, selectedDateTime: _selectedDateTime,)
                  : CardiJeune.moveToSuccess
                  ? Success()
                  : Signup(
                onSigninTapped: (newQ, newTop) {
                  updateContainerSize(newQ, newTop);
                  toggleLoginSignUp();
                },
                onContinueTapped: () {
                  navigateToActivitiesInformations();
                  if(_hasSelected){
                    updateContainerSize(0.7, 0.1);
                    stayInActivitiesInformations();
                  }
                },
                lastnameController: _lastnameController,
                firstnameController: _firstnameController,
                emailController: _emailController,
                numteleController: _numteleController,
                value: _value,
                age: _age,
                selectedDateTime: _selectedDateTime,
                onFormChange: onFormChange,
              ),
              ),
            ),
          ),
        ),
      );
  }
}
