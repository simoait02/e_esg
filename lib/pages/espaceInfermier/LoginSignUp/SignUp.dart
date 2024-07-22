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
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _numTeleFocusNode = FocusNode();



  bool _nomHasFocus = false;
  bool _prenomHasFocus = false;
  bool _cinHasFocus = false;
  bool _inpeHasFocus = false;
  bool _emailHasFocus = false;
  bool _numTeleHasFocus = false;

  String? _nomError;
  String? _prenomError;
  String? _cinError;
  String? _inpeError;
  String? _emailError;
  String? _numTeleError;

  bool yes1 = false;
  bool no1 = true;
  bool yes2 = false;
  bool no2 = true;

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
    _emailFocusNode.dispose();
    _numTeleFocusNode.dispose();
    super.dispose();
  }

  Widget buildTextField(double width, double height, String placeholder, FocusNode focusNode, bool hasFocus, bool isDarkMode, TextEditingController controller, String? error) {
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
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  bool validateForm() {
    bool isValid = true;
    setState(() {
      _nomError = null;
      _prenomError = null;
      _cinError = null;
      _inpeError = null;
      _emailError = null;
      _numTeleError = null;

      if (CardiInf.nomController.text.isEmpty) {
        _nomError = "Name is required";
        isValid = false;
      } else if (!CardiInf.nomController.text.contains(RegExp(r'^[a-zA-Z]+$'))) {
        _nomError = "Name must contain only letters";
        isValid = false;
      }

      if (CardiInf.prenomController.text.isEmpty) {
        _prenomError = "Surname is required";
        isValid = false;
      } else if (!CardiInf.prenomController.text.contains(RegExp(r'^[a-zA-Z]+$'))) {
        _prenomError = "Surname must contain only letters";
        isValid = false;
      }

      if (CardiInf.cinController.text.isEmpty) {
        _cinError = "CIN is required";
        isValid = false;
      } else if (CardiInf.cinController.text.length != 8 ) {
        _cinError = "CIN must be 8 digits";
        isValid = false;
      }

      if (CardiInf.inpeController.text.isEmpty) {
        _inpeError = "INPE is required";
        isValid = false;
      } else if (CardiInf.inpeController.text.contains(RegExp(r'[a-zA-Z]'))) {
        _inpeError = "INPE must not contain letters";
        isValid = false;
      }

      if (CardiInf.emailController.text.isEmpty) {
        _emailError = "Email is required";
        isValid = false;
      } else if (!CardiInf.emailController.text.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
        _emailError = "Invalid email address";
        isValid = false;
      }

      if (CardiInf.numTeleController.text.isEmpty) {
        _numTeleError = "Phone number is required";
        isValid = false;
      } else if (CardiInf.numTeleController.text.contains(RegExp(r'[a-zA-Z]'))) {
        _numTeleError = "Phone number must not contain letters";
        isValid = false;
      }
    });
    return isValid;
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
                        color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height * 0.025,
                                margin: const EdgeInsets.only(left: 10),
                                child: AutoSizeText(
                                  appLocalizations.nom,
                                  style: TextStyle(color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                                )),
                            buildTextField(width * 0.5, height, "", _nomFocusNode, _nomHasFocus, CardiInf.isDarkMode.value, CardiInf.nomController, _nomError),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height * 0.025,
                                margin: const EdgeInsets.only(left: 10),
                                child: AutoSizeText(
                                  appLocalizations.prenom,
                                  style: TextStyle(color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                                )),
                            buildTextField(width * 0.5, height, "", _prenomFocusNode, _prenomHasFocus, CardiInf.isDarkMode.value, CardiInf.prenomController, _prenomError),
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
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height * 0.025,
                                margin: const EdgeInsets.only(left: 10),
                                child: AutoSizeText(
                                  "CIN",
                                  style: TextStyle(color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                                )),
                            buildTextField(width * 0.5, height, "", _cinFocusNode, _cinHasFocus, CardiInf.isDarkMode.value, CardiInf.cinController, _cinError),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height * 0.025,
                                margin: const EdgeInsets.only(left: 10),
                                child: AutoSizeText(
                                  "INPE",
                                  style: TextStyle(color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                                )),
                            buildTextField(width * 0.5, height, "", _inpeFocusNode, _inpeHasFocus, CardiInf.isDarkMode.value, CardiInf.inpeController, _inpeError),
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
                      style: TextStyle(color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: buildTextField(width, height, "", _emailFocusNode, _emailHasFocus, CardiInf.isDarkMode.value, CardiInf.emailController, _emailError)),

                const SizedBox(height: 10),
                Container(
                    height: height * 0.025,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: AutoSizeText(
                      appLocalizations.tele,
                      style: TextStyle(color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                    )),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: buildTextField(width, height, "", _numTeleFocusNode, _numTeleHasFocus, CardiInf.isDarkMode.value, CardiInf.numTeleController, _numTeleError)),

                const SizedBox(height: 10),
                Column(
                  children: [
                    CupertinoButton(
                        child: Container(
                            width: width * 0.3,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [Color(0xff4E57CD), Color(0xff2F38A5)]),
                                borderRadius: BorderRadius.circular(40)),
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              appLocalizations.suivant,
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                            )),
                        onPressed: () {
                          if (validateForm()) {
                            CardiInf.q = 0.45;
                            CardiInf.top = 0.25;
                            widget.onContinueTapped();
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20),
                        SizedBox(
                          height: height * 0.04,
                          child: AutoSizeText(
                            appLocalizations.haveAcc,
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 10,
                                color: CardiInf.isDarkMode.value ? Colors.white : Colors.black),
                          ),
                        ),
                        const SizedBox(width: 2),
                        GestureDetector(
                          onTap: () {
                            widget.onSigninTapped(0.55, 0.25);
                          },
                          child: Container(
                            height: height * 0.04,
                            child: AutoSizeText(
                              appLocalizations.login,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "Inter",
                                  color: CardiInf.isDarkMode.value ? const Color(0xff759cd8) : const Color(0xff3a01de)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ]),
    );
  }
}
