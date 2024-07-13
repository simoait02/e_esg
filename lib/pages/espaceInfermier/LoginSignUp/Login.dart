import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/NavigationBarDoctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Cardi.dart';

class Login extends StatefulWidget {
  final Function(double, double) onSignUpTapped;

  Login({super.key, required this.onSignUpTapped});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _emailHasFocus = false;
  bool _passwordHasFocus = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {
        _emailHasFocus = _emailFocusNode.hasFocus;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordHasFocus = _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget buildLabel(String label,double height,bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(left: 40,top: height),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(fontFamily: "Inter",fontSize: 15,color: isDarkMode?Colors.white:Colors.black,
          ),
        ),
      ),
    );
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
        onTapOutside: (event) => setState(() {
          focusNode.unfocus;
        }),
        placeholder: placeholder,
        placeholderStyle: TextStyle(
          color: isDarkMode?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return  SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left:30),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: height*0.07,
                  width: width*0.2,
                  child: AutoSizeText(
                      "Login",
                    style: TextStyle(
                      color: CardiInf.isDarkMode.value?Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "poppins"
                    ),
                  ),
                ),
              ),
            ),
            buildLabel("Identifiant",height*0.02,CardiInf.isDarkMode.value),
            const SizedBox(height: 5,),
            buildTextField(width,height, "E-mail, CIN", _emailFocusNode, _emailHasFocus,CardiInf.isDarkMode.value),
            buildLabel("Password",height*0.02,CardiInf.isDarkMode.value),
            const SizedBox(height: 5,),
            buildTextField(width, height,"Password", _passwordFocusNode, _passwordHasFocus,CardiInf.isDarkMode.value),
            const SizedBox(height: 10,),
            CupertinoButton(
                child: Container(
                    width: width * 0.3,
                    height: height*0.05,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff0b40ff), Color(0xff0c40a4)]),
                        borderRadius: BorderRadius.circular(40)),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => NavbarDoc()),
                        (Route<dynamic> route) => false,
                  );

                }),
            const SizedBox(height: 10,),
            Container(
              height: height*0.04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20,),
                  AutoSizeText(
                    "Need an account?",
                    style: TextStyle(fontFamily: "Inter", color: CardiInf.isDarkMode.value?Colors.white:Colors.black,),
                  ),
                  const SizedBox(width: 2,),
                  GestureDetector(
                    onTap: () {
                      widget.onSignUpTapped(0.63, 0.1);
                    },
                    child:  AutoSizeText(
                      "Sign Up",
                      style: TextStyle(
                          fontFamily: "Inter",
                          color: CardiInf.isDarkMode.value? Color(0xff759cd8):Color(0xff3a01de)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
