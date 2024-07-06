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

  Widget buildTextField(double width, String placeholder, FocusNode focusNode, bool hasFocus) {
    return Container(
      width: width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: hasFocus ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: CupertinoTextField(
        focusNode: focusNode,
        placeholder: placeholder,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(

      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 80,
                    width: 160,
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logoEsj.png"),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left:30),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
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
                            Container(margin: EdgeInsets.only(left:10) ,child: const Text("Nom")),
                            buildTextField(width * 0.5, "", _nomFocusNode, _nomHasFocus),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(margin: EdgeInsets.only(left:10) ,child: const Text("Prénom")),
                            buildTextField(width * 0.5, "", _prenomFocusNode, _prenomHasFocus),
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
                            Container(margin: EdgeInsets.only(left:10) ,child: const Text("CIN")),
                            buildTextField(width * 0.5, "", _cinFocusNode, _cinHasFocus),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(margin: EdgeInsets.only(left:10) ,child: const Text("INPE")),
                            buildTextField(width * 0.5, "", _inpeFocusNode, _inpeHasFocus),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(margin: EdgeInsets.only(left:10) ,child: const Text("PPR")),
                            buildTextField(width * 0.5, "", _pprFocusNode, _pprHasFocus),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft ,child: Container(margin: EdgeInsets.only(left:30) ,child: const Text("E-mail"))),
                buildTextField(width, "", _emailFocusNode, _emailHasFocus),

                const SizedBox(height: 10,),
                Align(alignment: Alignment.centerLeft ,child: Container(margin: EdgeInsets.only(left:30) ,child: const Text("Numéro de téléphone"))),
                buildTextField(width, "", _numTeleFocusNode, _numTeleHasFocus),

                const SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(alignment: Alignment.centerLeft ,child: Container(margin: EdgeInsets.only(left:10) ,child: const Text("Médecin au sein d’un centre ESJ?"))),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:yes1?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: Text("Oui",textAlign: TextAlign.center,style: TextStyle(color:yes1?Color(0xff0b40ff) : Colors.grey),),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:no1?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: Text("Non",textAlign: TextAlign.center,style: TextStyle(color:no1?Color(0xff0b40ff) : Colors.grey),),
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
                      Align(alignment: Alignment.centerLeft ,child: Container(margin: EdgeInsets.only(left:10) ,child: const Text("Médecin Généraliste?"))),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:yes2?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: Text("Oui",textAlign: TextAlign.center,style: TextStyle(color:yes2?Color(0xff0b40ff) : Colors.grey),),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color:no2?Color(0xff0b40ff) : Colors.grey)
                              ),
                              child: Text("Non",textAlign: TextAlign.center,style: TextStyle(color:no2?Color(0xff0b40ff) : Colors.grey),),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                yes2? Align(alignment: Alignment.centerLeft ,child: Container(margin: EdgeInsets.only(left:30) ,child: const Text("Specialitée"))):Container(),
                yes2? buildTextField(width, "", _specialiteFocusNode, _specialiteHasFocus):const SizedBox(height: 70,),

              ],
            ),

            Column(
              children: [
                CupertinoButton(
                    child: Container(
                        width: width * 0.4,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xff0b40ff), Color(0xff0c40a4)]),
                            borderRadius: BorderRadius.circular(40)),
                        alignment: Alignment.center,
                        child: const Text(
                          "Suivant",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    onPressed: () {
                      Cardi.q = 0.45;
                      Cardi.top = 0.25;
                      widget.onContinueTapped();
                    }),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontFamily: "Inter"),
                    ),
                    const SizedBox(width: 2,),
                    GestureDetector(
                      onTap: () {
                        widget.onSigninTapped(0.45, 0.25);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontFamily: "Inter",
                            color: Color(0xff3a01de)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
              ],
            ),

          ],
        ),
    );
  }
}
