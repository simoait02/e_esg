import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
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




  Future<void> postData() async {
    final url = Uri.parse("http://192.168.1.10:8080/register/medecins");

    Map<String, dynamic> data = {
      "cin": "cinValue",
      "inpe": "inpeValue",
      "ppr": "pprValue",
      "estMedcinESJ": false,
      "estGeneraliste": true,
      "specialite": "gh",
      "infoUser": {
        "nom": "Dupont",
        "prenom": "Jean",
        "numTel": "0645678920",
        "mail": "ilyas.nom@gmail.com",
        "motDePasse": "password123"
      }
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        print('Data posted successfully: ${response.body}');
      } else {
        print('Failed to post data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }




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

  Widget buildTextField(double width, double height, String placeholder, FocusNode focusNode, bool hasFocus, bool isDarkMode,TextEditingController controller) {
    return SizedBox(
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
                  : (hasFocus ? Color(0xFF2E37A4) : Color(0xFFEAEBF6)),
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
                          buildTextField(width * 0.5, height, "", _nomFocusNode, _nomHasFocus, Cardi.isDarkMode.value,Cardi.nomController),
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
                          buildTextField(width * 0.5, height, "", _prenomFocusNode, _prenomHasFocus, Cardi.isDarkMode.value,Cardi.prenomController),
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
                          buildTextField(width * 0.5, height, "", _cinFocusNode, _cinHasFocus, Cardi.isDarkMode.value,Cardi.cinController),
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
                          buildTextField(width * 0.5, height, "", _inpeFocusNode, _inpeHasFocus, Cardi.isDarkMode.value,Cardi.inpeController),
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
                          buildTextField(width * 0.5, height, "", _pprFocusNode, _pprHasFocus, Cardi.isDarkMode.value,Cardi.pprController),
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: buildTextField(width, height, "", _emailFocusNode, _emailHasFocus, Cardi.isDarkMode.value,Cardi.emailController)),
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
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: buildTextField(width, height, "", _numTeleFocusNode, _numTeleHasFocus, Cardi.isDarkMode.value,Cardi.teleController)),
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      Cardi.q = 0.45;
                      Cardi.top = 0.25;
                      widget.onContinueTapped();
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
                          widget.onSigninTapped(0.5, 0.25);
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
