import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Card.dart';

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
  final FocusNode _pprFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _numTeleFocusNode = FocusNode();
  final FocusNode _specialiteFocusNode = FocusNode();
  bool _nomHasFocus = false;
  bool _prenomHasFocus = false;
  bool _cinHasFocus = false;
  bool _inpeHasFocus = false;
  bool _pprHasFocus = false;
  bool _emailHasFocus = false;
  bool _numTeleHasFocus = false;
  bool _specialiteHasFocus = false;
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
    _specialiteFocusNode.addListener(() {
      setState(() {
        _specialiteHasFocus = _specialiteFocusNode.hasFocus;
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
            color: isDarkMode? hasFocus?CupertinoColors.systemBlue: CupertinoColors.white.withOpacity(0.5):hasFocus?CupertinoColors.systemBlue:CupertinoColors.black.withOpacity(0.5),
            width: 1,
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SingleChildScrollView(

      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left:30),
                  height: height*0.07,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: "poppins"
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
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
                                child: const AutoSizeText("Nom")),
                            buildTextField(width * 0.5,height, "", _nomFocusNode, _nomHasFocus,isDarkMode),
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
                                child: const AutoSizeText("Prénom")),
                            buildTextField(width * 0.5, height,"", _prenomFocusNode, _prenomHasFocus,isDarkMode),
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
                        width: width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: const AutoSizeText("CIN")),
                            buildTextField(width * 0.5,height, "", _cinFocusNode, _cinHasFocus,isDarkMode),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: const AutoSizeText("INPE")),
                            buildTextField(width * 0.5, height,"", _inpeFocusNode, _inpeHasFocus,isDarkMode),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: const AutoSizeText("PPR")),
                            buildTextField(width * 0.5,height, "", _pprFocusNode, _pprHasFocus,isDarkMode),
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
                        child: const AutoSizeText("E-mail")
                    )
                ),
                buildTextField(width, height,"", _emailFocusNode, _emailHasFocus,isDarkMode),

                const SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft ,
                    child: Container(
                        height: height*0.025,
                        margin: EdgeInsets.only(left:30) ,
                        child: const AutoSizeText("Numéro de téléphone")
                    )
                ),
                buildTextField(width,height, "", _numTeleFocusNode, _numTeleHasFocus,isDarkMode),

                const SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(alignment: Alignment.centerLeft ,
                          child: Container(
                              height: height*0.045,
                              margin: EdgeInsets.only(left:10) ,
                              child: const AutoSizeText("Médecin au sein \nd’un centre ESJ?")
                          )
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                yes1=!yes1;
                                no1=!no1;
                              });
                            },
                            child: Container(
                              width: width*0.09,
                              height: height*0.025,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:yes1?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: AutoSizeText("Oui",textAlign: TextAlign.center,style: TextStyle(color:yes1?Color(0xff0b40ff) : Colors.grey),),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                no1=!no1;
                                yes1=!yes1;
                              });
                            },
                            child: Container(
                              width: width*0.09,
                              height: height*0.025,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:no1?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: AutoSizeText("Non",style: TextStyle(color:no1?Color(0xff0b40ff) : Colors.grey),),
                            ),
                          )
                        ],
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
                      Align(alignment: Alignment.centerLeft ,
                          child: Container(
                              height: height*0.025,
                              margin: EdgeInsets.only(left:10) ,
                              child: const AutoSizeText("Médecin Généraliste?")
                          )
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                yes2=!yes2;
                                no2=!no2;
                              });
                            },
                            child: Container(
                              width: width*0.09,
                              height: height*0.025,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:yes2?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: AutoSizeText("Oui",textAlign: TextAlign.center,style: TextStyle(color:yes2?Color(0xff0b40ff) : Colors.grey),),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                no2=!no2;
                                yes2=!yes2;
                              });
                            },
                            child: Container(
                              width: width*0.09,
                              height: height*0.025,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:no2?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: AutoSizeText("Non",style: TextStyle(color:no2?Color(0xff0b40ff) : Colors.grey),),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                yes2? Align(alignment: Alignment.centerLeft ,
                    child: Container(
                      height: height*0.025,
                        margin: EdgeInsets.only(left:30) ,
                        child: const AutoSizeText("Specialitée"))):SizedBox(height: height*0.025,),
                yes2? buildTextField(width, height,"", _specialiteFocusNode, _specialiteHasFocus,isDarkMode):SizedBox(height: height*0.055,),

              ],
            ),

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
                      Cardi.q = 0.45;
                      Cardi.top = 0.25;
                      widget.onContinueTapped();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    Container(
                      height: height*0.025,
                      child: const AutoSizeText(
                        "Already have an account?",
                        style: TextStyle(fontFamily: "Inter"),
                      ),
                    ),
                    const SizedBox(width: 2,),
                    GestureDetector(
                      onTap: () {
                        widget.onSigninTapped(0.5, 0.25);
                      },
                      child: Container(
                        height: height*0.025,
                        child: AutoSizeText(
                          "Sign In",
                          style: TextStyle(
                              fontFamily: "Inter",
                              color: isDarkMode? Color(0xff759cd8):Color(0xff3a01de)),
                        ),
                      ),
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
