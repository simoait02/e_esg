import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'Cardi.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Signup extends StatefulWidget {
  final Function(double, double) onSigninTapped;
  final Function() onContinueTapped;


  const Signup({
    required this.onSigninTapped,
    required this.onContinueTapped,
    super.key,
  });

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FocusNode _nomFocusNode = FocusNode();
  final FocusNode _prenomFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _numTeleFocusNode = FocusNode();
  bool _nomHasFocus = false;
  bool _prenomHasFocus = false;
  bool _emailHasFocus = false;
  bool _numTeleHasFocus = false;
  bool lastnamenull = false;
  bool firstnamenull = false;
  bool emailnull = false;
  bool numtelenull = false;
  bool datenull = false;
  bool tooyoung=false;
  bool tooold=false;
  int _value = 0;
  String errorText="";

  DateTime? selectedDateTime;
  DateTime? tempSelectedDateTime;
  late String label;

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

    _value = CardiJeune.value;
    selectedDateTime = CardiJeune.selectedDateTime;
    label = CardiJeune.selectedDateTime != null
        ? intl.DateFormat.yMMMMd().format(CardiJeune.selectedDateTime!)
        : "date de naissance";
  }

  @override
  void dispose() {
    _nomFocusNode.dispose();
    _prenomFocusNode.dispose();
    _emailFocusNode.dispose();
    _numTeleFocusNode.dispose();
    super.dispose();
  }

  Widget buildLabel(String label, double height, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(left: 40, top: height),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      double width,
      double height,
      String placeholder,
      TextEditingController controller,
      FocusNode focusNode,
      bool hasFocus,
      bool isDarkMode,
      bool error,
      ) {
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
              color: hasFocus
                  ? Color(0xFF2E37A4)
                  : error
                  ? Colors.red
                  : isDarkMode
                  ? CupertinoColors.white.withOpacity(0.5)
                  : Color(0xFFEAEBF6),
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

  void updateDate(DateTime newDate) {
    setState(() {
      selectedDateTime = newDate;
      label = intl.DateFormat.yMMMMd().format(selectedDateTime!);
    });
  }

  bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final appLocalizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: height * 0.07,
                  child: AutoSizeText(
                    appLocalizations.signUp,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "poppins",
                    ),
                  ),
                ),
              ),
              Container(
                height: height * 0.04,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: AutoSizeText(
                  appLocalizations.sex,
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                        fillColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xff00D3C7);
                            }
                            return null;
                          },
                        ),
                      ),
                      AutoSizeText(
                        appLocalizations.female,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                        fillColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xff00D3C7);
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 4),
                      AutoSizeText(
                        appLocalizations.male,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.37,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.03,
                            margin: EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              appLocalizations.nom,
                              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                            ),
                          ),
                          buildTextField(width * 0.5, height, "", CardiJeune.lastnameController, _nomFocusNode, _nomHasFocus, isDarkMode, lastnamenull),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.37,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.03,
                            margin: EdgeInsets.only(left: 10),
                            child: AutoSizeText(
                              appLocalizations.prenom,
                              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                            ),
                          ),
                          buildTextField(width * 0.5, height, "", CardiJeune.firstnameController, _prenomFocusNode, _prenomHasFocus, isDarkMode, firstnamenull),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.015),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.03,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: AutoSizeText(
                      appLocalizations.birthDay,
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tempSelectedDateTime = selectedDateTime;
                      });
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: width,
                            height: height * 0.35,
                            color: isDarkMode ? CupertinoColors.black : CupertinoColors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CupertinoButton(
                                      child: Text(
                                        appLocalizations.cancel,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoButton(
                                      child: Text(
                                        appLocalizations.done,
                                        style: TextStyle(color: Color(0xff2E37A5)),
                                      ),
                                      onPressed: () {
                                        if (tempSelectedDateTime != null) {
                                          updateDate(tempSelectedDateTime!);
                                        }
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: CupertinoTheme(
                                    data: CupertinoThemeData(
                                      textTheme: CupertinoTextThemeData(
                                        dateTimePickerTextStyle: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                            color: isDarkMode ? Colors.white : Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: CupertinoDatePicker(
                                      initialDateTime: selectedDateTime ?? DateTime.now(),
                                      onDateTimeChanged: (DateTime newDate) {
                                        setState(() {
                                          tempSelectedDateTime = newDate;
                                        });
                                      },
                                      mode: CupertinoDatePickerMode.date,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: height * 0.055,
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: datenull ? Colors.red : isDarkMode
                              ? CupertinoColors.white.withOpacity(0.5)
                              : Color(0xFFEAEBF6),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            label,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Icon(
                            CupertinoIcons.calendar,
                            color: isDarkMode
                                ? CupertinoColors.white.withOpacity(0.5)
                                : Color(0xFFEAEBF6),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),
              Container(
                height: height * 0.03,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: AutoSizeText(
                  appLocalizations.email,
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: buildTextField(width, height, "", CardiJeune.emailController, _emailFocusNode, _emailHasFocus, isDarkMode, emailnull),
              ),
              SizedBox(height: height * 0.015),
              Container(
                height: height * 0.03,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: AutoSizeText(
                  appLocalizations.tele,
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: buildTextField(width, height, "", CardiJeune.numteleController, _numTeleFocusNode, _numTeleHasFocus, isDarkMode, numtelenull),
              ),
            ],
          ),
          Column(
            children: [
              Visibility(
                visible: datenull ||tooyoung||tooold|| lastnamenull || firstnamenull || emailnull || numtelenull || _value == 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(child:AutoSizeText(
                    errorText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  )),
                ),
              ),
              CupertinoButton(
                child: Container(
                  width: width * 0.3,
                  height: height * 0.055,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
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
                  final lastname = CardiJeune.lastnameController.text;
                  final firstname = CardiJeune.firstnameController.text;
                  final email = CardiJeune.emailController.text;
                  final numtele = CardiJeune.numteleController.text;
                  final int age = (selectedDateTime != null) ? DateTime.now().year - selectedDateTime!.year : 0;
                  setState(() {
                    CardiJeune.value=_value;
                    CardiJeune.age=age;
                    CardiJeune.selectedDateTime=selectedDateTime;
                    lastnamenull = lastname.isEmpty;
                    firstnamenull = firstname.isEmpty;
                    emailnull = email.isEmpty || !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
                    numtelenull = numtele.isEmpty || !RegExp(r'^\d{10}$').hasMatch(numtele);
                    datenull = selectedDateTime == null;
                    tooyoung = selectedDateTime != null && age < 10;
                    tooold = selectedDateTime != null && age > 30;
                    if (lastnamenull || firstnamenull || emailnull || numtelenull || datenull || _value == 0) {
                      errorText = "Prière de valider vos informations";
                    } else if (tooyoung) {
                      errorText = "Vous devez avoir plus de 10 ans pour créer un compte";
                    } else if (tooold) {
                      errorText = "Vous devez avoir moins de 30 ans pour créer un compte";
                    } else {
                      errorText = "";
                    }});

                  if (!(datenull||tooyoung||tooold || lastnamenull || firstnamenull || emailnull || numtelenull || _value == 0)) {
                    CardiJeune.q = 0.45;
                    CardiJeune.top = 0.25;
                    widget.onContinueTapped();
                  }
                },
              ),
              Container(
                height: height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    AutoSizeText(
                      appLocalizations.haveAcc,
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Color(0xff9999A3),
                        fontWeight: FontWeight.w400,
                        fontSize: width * 0.04,
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        widget.onSigninTapped(0.6, 0.25);
                      },
                      child: AutoSizeText(
                        appLocalizations.login,
                        style: TextStyle(
                          fontFamily: "Inter",
                          color: isDarkMode ? Color(0xff759cd8) : Color(0xff3a01de),
                          fontWeight: FontWeight.w400,
                          fontSize: width * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
