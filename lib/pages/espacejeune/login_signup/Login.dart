import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/NavigationBarJeune.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
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
            color: isDarkMode? hasFocus?CupertinoColors.systemBlue: CupertinoColors.white.withOpacity(0.5):hasFocus?CupertinoColors.systemBlue:Color(0xFFEAEBF6),
            width: 2,
          ),
        ),
        focusNode: focusNode,
        onTapOutside: (event) => setState(() {
          focusNode.unfocus;
        }),
        placeholder: placeholder,
        placeholderStyle: TextStyle(
          color: isDarkMode?Colors.white.withOpacity(0.5):Color(0xFFEAEBF6),
        ),
        style:TextStyle(
          color: isDarkMode?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            margin: EdgeInsets.only(left:30),
            child:  Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: height*0.07,
                width: width*0.2,
                child: AutoSizeText(
                  "Login",
                  style: TextStyle(
                      color: isDarkMode?Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "poppins"
                  ),
                ),
              ),
            ),
          ),
          buildLabel("Identifiant",height*0.02,isDarkMode),
          buildTextField(width,height, "E-mail, CIN, CNE, Code Massar", _emailFocusNode, _emailHasFocus,Cardi.isDarkMode.value),
          buildLabel("Password",height*0.02,isDarkMode),
          buildTextField(width, height,"Password", _passwordFocusNode, _passwordHasFocus,Cardi.isDarkMode.value),
          SizedBox(height: height*0.01,),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: AutoSizeText("Mot de passe oublié?",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: width * 0.04,
                fontFamily: "Poppins",
                color: Color(0xff00D3C7)
              ),),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:width*0.05),
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
                    color: isDarkMode?Colors.white:Colors.black,
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
                  height: height*0.05,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff4E57CD), Color(0xff2F38A5)]),
                      borderRadius: BorderRadius.circular(40)),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavbarYouth()),
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
