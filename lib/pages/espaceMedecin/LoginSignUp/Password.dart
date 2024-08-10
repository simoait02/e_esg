import 'package:dio/dio.dart';
import 'package:e_esg/api/Dio_Consumer.dart';
import 'package:e_esg/api/api_Comsumer.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/api/errors/Exceptions.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../IES/statistiques.dart';

class Password extends StatefulWidget {
  final Function(double, double) onBackTapped;
  final Function(double, double) onConfirmTapped;

  Password({super.key, required this.onBackTapped,required this.onConfirmTapped});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool passwordvisible = false;
  bool passwordvisible2 = false;
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController copasswordController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  FocusNode _focusNode2 = FocusNode();
  bool _isFocused2 = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });

    passwordController.addListener(() {
      setState(() {}); // Rebuild the UI on every text change
    });
    copasswordController.addListener(() {
      setState(() {}); // Rebuild the UI on every text change
    });
  }
  final ApiComsumer api=DioConsumer(dio: Dio());

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  void _showPassword() {
    setState(() {
      passwordvisible = !passwordvisible;
      if (_isFocused) _isFocused = true;
    });
  }

  void _showPassword2() {
    setState(() {
      passwordvisible2 = !passwordvisible2;
      if (_isFocused2) _isFocused2 = true;
    });
  }

  bool error = false;

  bool validatePassword(String password) {
    // Check for minimum length
    if (password.length < 6) {
      return false;
    }

    // Check for at least one digit
    if (!RegExp(r'\d').hasMatch(password)) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height * 0.07,
            width: width * 0.7,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                appLocalizations!.createPass,
                maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                  fontFamily: "poppins",
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.password,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: titleFontSize + 15,
                    color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                ),
                Container(
                  height: 51,
                  padding: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isFocused
                          ? (validatePassword(passwordController.text) ? Colors.green : Colors.red)
                          : (Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : const Color(0xFFEAEBF6)),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: passwordController,
                          style: TextStyle(
                            color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                          ),
                          focusNode: _focusNode,
                          autofocus: false,
                          obscureText: !passwordvisible,
                          cursorColor: const Color(0xFF2E37A4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 0),
                          ),
                          onTapOutside: (PointerDownEvent event) {
                            _focusNode.unfocus();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: _showPassword,
                        highlightColor: Colors.transparent,
                        icon: Container(
                          width: iconButtonSize + 30,
                          height: iconButtonSize + 30,
                          child: passwordvisible
                              ? Image.asset('assets/images/invisible.png')
                              : Image.asset('assets/images/visible.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!validatePassword(passwordController.text) && passwordController.text.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Password must be at least 6 characters long and include at least one digit.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/images/warning.svg",
                  color: const Color(0xff59E2DB),
                ),
                const Expanded(
                  child: Text(
                    "The password should be at least 6 characters long and contain at least one numerical character.",
                    style: TextStyle(fontSize: 10, color: Color(0xff9999A3)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.confirmPass,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: titleFontSize + 15,
                    color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                ),
                Container(
                  height: 51,
                  padding: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: error
                          ? Colors.red
                          : Cardi.isDarkMode.value
                          ? (_isFocused2 ? const Color(0xFF2E37A4) : CupertinoColors.white.withOpacity(0.5))
                          : (_isFocused2 ? const Color(0xFF2E37A4) : const Color(0xFFEAEBF6)),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: copasswordController,
                          style: TextStyle(
                            color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                          ),
                          focusNode: _focusNode2,
                          autofocus: false,
                          obscureText: !passwordvisible2,
                          cursorColor: const Color(0xFF2E37A4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 0),
                          ),
                          onTapOutside: (PointerDownEvent event) {
                            _focusNode2.unfocus();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: _showPassword2,
                        highlightColor: Colors.transparent,
                        icon: Container(
                          width: iconButtonSize + 30,
                          height: iconButtonSize + 30,
                          child: passwordvisible2
                              ? Image.asset('assets/images/invisible.png')
                              : Image.asset('assets/images/visible.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                  width: width * 0.3,
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xff4E57CD)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    appLocalizations.precedent,
                    style: const TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                  ),
                ),
                onPressed: () {
                  widget.onBackTapped(0.5, 0.1);
                },
              ),
              CupertinoButton(
                onPressed: () async {
                  if (passwordController.text == copasswordController.text) {
                    if (validatePassword(passwordController.text)) {
                      try {
                        await api.post(
                          EndPoints.RegisterMedecin,
                          data:{
                            "cin": Cardi.cinController.text,
                            "inpe": Cardi.inpeController.text,
                            "ppr": Cardi.pprController.text,
                            "estMedcinESJ": Cardi.isEsgDoctor,
                            "estGeneraliste": Cardi.isGeneralist,
                            "specialite": Cardi.specialiteeController.text,
                            "infoUser": {
                              "nom": Cardi.nomController.text,
                              "prenom": Cardi.prenomController.text,
                              "numTel": Cardi.teleController.text,
                              "mail": Cardi.emailController.text,
                              "motDePasse": passwordController.text
                            }
                          },
                          headers: {},
                        );
                        Fluttertoast.showToast(msg: "success",backgroundColor: Colors.greenAccent,textColor: Colors.black);
                        widget.onConfirmTapped(0.55, 0.25);
                      } on ServerException catch (e) {
                        print("dfffffffffffffffffffffffffffffffffffffffffffffffffffff");
                        Fluttertoast.showToast(msg: e.errormodel.errorMsg,backgroundColor: Colors.red);
                      }
                    } else {
                      setState(() {
                        error = true;
                      });
                      Fluttertoast.showToast(msg: "Password does not meet the criteria", backgroundColor: Colors.red);
                    }

                  } else {
                    setState(() {
                      error = true;
                    });
                    Fluttertoast.showToast(msg: "Passwords do not match", backgroundColor: Colors.red);
                  }
                },
                child: Container(
                  width: width * 0.4,
                  height: height * 0.06,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    appLocalizations.createAcc,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
