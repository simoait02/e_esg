import 'package:e_esg/pages/IES/calendrier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Widget buildLabel(String label) {
    return Container(
      margin: const EdgeInsets.only(left: 40, top: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(fontFamily: "Inter",fontSize: 15),
        ),
      ),
    );
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
    return  SingleChildScrollView(

      child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 70,
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
                    "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "poppins"
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            buildLabel("Identifiant"),
            const SizedBox(height: 5,),
            buildTextField(width, "E-mail, CIN", _emailFocusNode, _emailHasFocus),
            const SizedBox(height: 10,),
            buildLabel("Password"),
            const SizedBox(height: 5,),
            buildTextField(width, "Password", _passwordFocusNode, _passwordHasFocus),
            const SizedBox(height: 10,),
        
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
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Calendrier()));
                }),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                const Text(
                  "Need an account?",
                  style: TextStyle(fontFamily: "Inter"),
                ),
                const SizedBox(width: 2,),
                GestureDetector(
                  onTap: () {
                    widget.onSignUpTapped(0.7, 0.1);
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontFamily: "Inter",
                        color: Color(0xff3a01de)),
                  ),
                ),
              ],
            )
          ],
        ),
    );
  }
}
