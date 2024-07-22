import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Cardi.dart';

class Signup extends StatefulWidget {
  final Function(double, double) onSigninTapped;
  final Function() onContinueTapped;

  Signup({super.key, required this.onSigninTapped, required this.onContinueTapped});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FocusNode _nomFocusNode = FocusNode();
  final FocusNode _prenomFocusNode = FocusNode();
  final FocusNode _cinFocusNode = FocusNode();
  final FocusNode _inpeFocusNode = FocusNode();
  final FocusNode _pprFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _numTeleFocusNode = FocusNode();
  bool _nomHasFocus = false;
  bool _prenomHasFocus = false;
  bool _cinHasFocus = false;
  bool _inpeHasFocus = false;
  bool _pprHasFocus = false;
  bool _emailHasFocus = false;
  bool _numTeleHasFocus = false;
  bool _isEmailValid = true;
  bool _isInpeValid = true;
  bool _isPprValid = true;
  bool _isTeleValid = true;
  bool _isCinValid = true;
  bool _isNomValid = true;
  bool _isPrenomValid = true;

  @override
  void initState() {
    super.initState();
    _nomFocusNode.addListener(() {
      setState(() {
        _nomHasFocus = _nomFocusNode.hasFocus;
      });
    });
    _prenomFocusNode.addListener(() {
      setState(() {
        _prenomHasFocus = _prenomFocusNode.hasFocus;
      });
    });
    _cinFocusNode.addListener(() {
      setState(() {
        _cinHasFocus = _cinFocusNode.hasFocus;
      });
    });
    _inpeFocusNode.addListener(() {
      setState(() {
        _inpeHasFocus = _inpeFocusNode.hasFocus;
      });
    });
    _pprFocusNode.addListener(() {
      setState(() {
        _pprHasFocus = _pprFocusNode.hasFocus;
      });
    });
    _emailFocusNode.addListener(() {
      setState(() {
        _emailHasFocus = _emailFocusNode.hasFocus;
      });
    });
    _numTeleFocusNode.addListener(() {
      setState(() {
        _numTeleHasFocus = _numTeleFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nomFocusNode.dispose();
    _prenomFocusNode.dispose();
    _cinFocusNode.dispose();
    _inpeFocusNode.dispose();
    _pprFocusNode.dispose();
    _emailFocusNode.dispose();
    _numTeleFocusNode.dispose();
    super.dispose();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool validateNumber(String number) {
    final numberRegex = RegExp(r'^\d+$');
    return numberRegex.hasMatch(number);
  }

  bool validateCin(String cin) {
    return cin.length == 8 ;
  }

  bool validateName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z]{2,}$');
    return nameRegex.hasMatch(name);
  }

  Widget buildTextField(double width, double height, String placeholder, FocusNode focusNode, bool hasFocus, bool isDarkMode, TextEditingController controller, {bool isEmail = false, bool isNumber = false, bool isValid = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.8,
          height: height * 0.055,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: CupertinoTextField(
              controller: controller,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDarkMode
                      ? (hasFocus ? CupertinoColors.systemBlue : CupertinoColors.white.withOpacity(0.5))
                      : (hasFocus ? const Color(0xFF2E37A4) : const Color(0xFFEAEBF6)),
                  width: 2,
                ),
              ),
              focusNode: focusNode,
              onTapOutside: (event) => setState(() {
                focusNode.unfocus();
              }),
              placeholder: placeholder,
              placeholderStyle: TextStyle(
                color: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
        ),
        if (!isValid)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              'Invalid input',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: height * 0.07,
                child: AutoSizeText(
                  appLocalizations!.signUp,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "poppins",
                    color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.37,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.025,
                            margin: const EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              appLocalizations.nom,
                              style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                            ),
                          ),
                          buildTextField(width * 0.5, height, "", _nomFocusNode, _nomHasFocus, Cardi.isDarkMode.value, Cardi.nomController, isValid: _isNomValid),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.37,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.025,
                            margin: const EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              appLocalizations.prenom,
                              style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                            ),
                          ),
                          buildTextField(width * 0.5, height, "", _prenomFocusNode, _prenomHasFocus, Cardi.isDarkMode.value, Cardi.prenomController, isValid: _isPrenomValid),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.025,
                            margin: const EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              "CIN",
                              style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                            ),
                          ),
                          buildTextField(width * 0.5, height, "", _cinFocusNode, _cinHasFocus, Cardi.isDarkMode.value, Cardi.cinController, isValid: _isCinValid),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.025,
                            margin: const EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              "INPE",
                              style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                            ),
                          ),
                          buildTextField(width * 0.5, height, "", _inpeFocusNode, _inpeHasFocus, Cardi.isDarkMode.value, Cardi.inpeController, isNumber: true, isValid: _isInpeValid),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.025,
                            margin: const EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              "PPR",
                              style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                            ),
                          ),
                          buildTextField(width * 0.5, height, "", _pprFocusNode, _pprHasFocus, Cardi.isDarkMode.value, Cardi.pprController, isNumber: true, isValid: _isPprValid),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: height * 0.025,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: AutoSizeText(
                  appLocalizations.email,
                  style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: buildTextField(width, height, "", _emailFocusNode, _emailHasFocus, Cardi.isDarkMode.value, Cardi.emailController, isEmail: true, isValid: _isEmailValid),
              ),
              const SizedBox(height: 10),
              Container(
                height: height * 0.025,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: AutoSizeText(
                  appLocalizations.tele,
                  style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: buildTextField(width, height, "", _numTeleFocusNode, _numTeleHasFocus, Cardi.isDarkMode.value, Cardi.teleController, isNumber: true, isValid: _isTeleValid),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  CupertinoButton(
                    child: Container(
                      width: width * 0.3,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        appLocalizations.suivant,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isEmailValid = validateEmail(Cardi.emailController.text);
                        _isInpeValid = validateNumber(Cardi.inpeController.text);
                        _isPprValid = validateNumber(Cardi.pprController.text);
                        _isTeleValid = validateNumber(Cardi.teleController.text);
                        _isCinValid = validateCin(Cardi.cinController.text);
                        _isNomValid = validateName(Cardi.nomController.text);
                        _isPrenomValid = validateName(Cardi.prenomController.text);
                      });

                      if (_isEmailValid && _isInpeValid && _isPprValid && _isTeleValid && _isCinValid && _isNomValid && _isPrenomValid) {
                        Cardi.q = 0.45;
                        Cardi.top = 0.25;
                        widget.onContinueTapped();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      SizedBox(
                        height: height * 0.04,
                        child: AutoSizeText(
                          appLocalizations.haveAcc,
                          style: TextStyle(fontFamily: "Inter", color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                        ),
                      ),
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          widget.onSigninTapped(0.55, 0.25);
                        },
                        child: SizedBox(
                          height: height * 0.04,
                          child: AutoSizeText(
                            appLocalizations.login,
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: Cardi.isDarkMode.value ? const Color(0xff759cd8) : const Color(0xff3a01de),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
