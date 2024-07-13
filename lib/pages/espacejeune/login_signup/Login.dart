import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Pages/IES/calendrier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_esg/Widgets/text_field.dart';

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
  bool remember=false;

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

  Widget buildLabel(String label, double height) {
    return Container(
      margin: EdgeInsets.only(left: 40, top: height),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(fontFamily: "Inter", fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;


    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: height * 0.07,
                width: width * 0.2,
                child: AutoSizeText(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.3,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ),
          ),
          CustomTextField(title: 'Identifiant', hint: "Email/CIN/CNE/Code Massar",height: 10,),
          CustomTextField(title: 'Mot de passe', hint: "Mot de passe",height: 10),
          Padding(padding: EdgeInsets.symmetric(horizontal:width*0.05),
          child: Row(
            children: [
              Spacer(),
              GestureDetector(
                child: AutoSizeText("Mot de passe oublié?",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04,
                  fontFamily: "Poppins",
                  color: Color(0xff00D3C7)
                ),),
              )
            ],
          ),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:width*0.05,vertical: 10),
            child: Row(
              children: [
                Checkbox(
                  value: remember,
                  onChanged: (bool? newValue) {
                    setState(() {
                       remember = !remember ;
                    });
                  },
                  activeColor: Color(0xFF2E37A4),
                  checkColor: Colors.white,
                  side: BorderSide(color: Color(0xffD6D6DA),width: 2),
                ),
                AutoSizeText(
                  "Se souvenir de moi",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: width * 0.04,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),

          CupertinoButton(
              child: Container(
                  width: width * 0.4,
                  height: 50,
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
                  MaterialPageRoute(builder: (context) => Calendrier()),
                      (Route<dynamic> route) => false,
                );

              }),
          const SizedBox(height: 5),
          Container(
            height: height * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 30),
                AutoSizeText(
                  "Vous n'avez pas de compte?",
                  style: TextStyle(fontFamily: "Inter",
                  color: Color(0xff9999A3),
                  fontWeight: FontWeight.w400,
                  fontSize: width*0.04),
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    widget.onSignUpTapped(0.8, 0.1);
                  },
                  child: AutoSizeText(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: "Inter",
                      color: isDarkMode ? Color(0xff759cd8) : Color(0xff3a01de),
                        fontWeight: FontWeight.w400,
                        fontSize: width*0.04
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
