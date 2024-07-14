import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Cardi.dart';

class Signup extends StatefulWidget {
  final Function(double, double) onSigninTapped;
  final Function() onContinueTapped;

  Signup({super.key, required this.onSigninTapped,required this.onContinueTapped});

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
  bool yes1=false;
  bool no1=true;
  bool yes2=false;
  bool no2=true;

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
    super.dispose();
  }

  Widget buildTextField(double width,double height, String placeholder, FocusNode focusNode, bool hasFocus,bool isDarkMode) {
    return Container(
      width: width * 0.8,
      height: height*0.055,
      child: CupertinoTextField(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDarkMode? hasFocus?CupertinoColors.systemBlue: CupertinoColors.white.withOpacity(0.5):hasFocus?Color(0xFF2E37A4):Color(0xFFEAEBF6),
            width: 2,
          ),
        ),
        focusNode: focusNode,
        placeholder: placeholder,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left:30),
                  height: height*0.07,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: "poppins",
                          color:CardiInf.isDarkMode.value?Colors.white:Colors.black
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: height*0.01,),
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
                              height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: AutoSizeText("Nom",
                                  style: TextStyle(color: CardiInf.isDarkMode.value?Colors.white:Colors.black),)),
                            buildTextField(width * 0.5,height, "", _nomFocusNode, _nomHasFocus,CardiInf.isDarkMode.value),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child:  AutoSizeText("Prénom",
                                style: TextStyle(color: CardiInf.isDarkMode.value?Colors.white:Colors.black),)),
                            buildTextField(width * 0.5, height,"", _prenomFocusNode, _prenomHasFocus,CardiInf.isDarkMode.value),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
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
                                height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: AutoSizeText("CIN",
                                  style: TextStyle(color: CardiInf.isDarkMode.value?Colors.white:Colors.black),)),
                            buildTextField(width * 0.5,height, "", _cinFocusNode, _cinHasFocus,CardiInf.isDarkMode.value),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: AutoSizeText("INPE",
                                  style: TextStyle(color: CardiInf.isDarkMode.value?Colors.white:Colors.black),)),
                            buildTextField(width * 0.5, height,"", _inpeFocusNode, _inpeHasFocus,CardiInf.isDarkMode.value),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft ,
                    child: Container(
                        height: height*0.025,
                        margin: EdgeInsets.only(left:30) ,
                        child: AutoSizeText("E-mail",
                          style: TextStyle(color: CardiInf.isDarkMode.value?Colors.white:Colors.black),)
                    )
                ),
                buildTextField(width, height,"", _emailFocusNode, _emailHasFocus,CardiInf.isDarkMode.value),

                const SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft ,
                    child: Container(
                        height: height*0.025,
                        margin: EdgeInsets.only(left:30) ,
                        child: AutoSizeText("Numéro de téléphone",
                          style: TextStyle(color: CardiInf.isDarkMode.value?Colors.white:Colors.black),)
                    )
                ),
                buildTextField(width,height, "", _numTeleFocusNode, _numTeleHasFocus,CardiInf.isDarkMode.value),

                const SizedBox(height: 10,),
            Column(
              children: [
                CupertinoButton(
                    child: Container(
                        width: width * 0.3,
                        height: height*0.05,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xff0b40ff), Color(0xff0c40a4)]),
                            borderRadius: BorderRadius.circular(40)),
                        alignment: Alignment.center,
                        child: const AutoSizeText(
                          "Suivant",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    onPressed: () {
                      CardiInf.q = 0.45;
                      CardiInf.top = 0.25;
                      widget.onContinueTapped();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     const SizedBox(width: 20,),
                    SizedBox(
                      height: height*0.04,
                      child:  AutoSizeText(
                        "Already have an account?",
                        style: TextStyle(fontFamily: "Inter",
                            color: CardiInf.isDarkMode.value?Colors.white:Colors.black),
                      ),
                    ),
                    const SizedBox(width: 2,),
                    GestureDetector(
                      onTap: () {
                        widget.onSigninTapped(0.5, 0.25);
                      },
                      child: Container(
                        height: height*0.04,
                        child: AutoSizeText(
                          "Sign In",
                          style: TextStyle(
                              fontFamily: "Inter",
                              color: CardiInf.isDarkMode.value? Color(0xff759cd8):Color(0xff3a01de)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),]
    ));
  }
}
