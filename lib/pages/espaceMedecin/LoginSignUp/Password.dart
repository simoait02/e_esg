import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/NavigationBarDoctor.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  final Function(double,double) onBackTapped;

  Password({super.key, required this.onBackTapped});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final FocusNode _coPasswordFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _coPasswordHasFocus = false;
  bool _passwordHasFocus = false;

  @override
  void initState() {
    super.initState();
    _coPasswordFocusNode.addListener(() {
      setState(() {
        _coPasswordHasFocus = _coPasswordFocusNode.hasFocus;
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
    _coPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget buildLabel(String label,bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.only(left: 40, top: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AutoSizeText(
          label,
          style: TextStyle(fontFamily: "Inter", fontSize: 15,
              color:isDarkMode?Colors.white:Colors.black
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
        children: [
          SizedBox(
            height: height*0.07,
            width: width*0.7,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                "Créer un mot de passe",
                maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                      color:Cardi.isDarkMode.value?Colors.white:Colors.black,
                      fontFamily: "poppins"),
              ),
            ),
          ),
          buildLabel("Mot de passe",Cardi.isDarkMode.value),
          const SizedBox(height: 5,),
          buildTextField(width,height, "", _coPasswordFocusNode, _coPasswordHasFocus,Cardi.isDarkMode.value),
          buildLabel("Confirmer mot de passe",Cardi.isDarkMode.value),
          const SizedBox(height: 5,),
          buildTextField(width, height,"", _passwordFocusNode, _passwordHasFocus,Cardi.isDarkMode.value),
           SizedBox(height: height*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                    width: width * 0.3,
                    height: height*0.05,
                    decoration: BoxDecoration(
                        color:Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Color(0xff4E57CD))),
                    alignment: Alignment.center,
                    child: Text(
                      "Precedent",
                      style: TextStyle(color:Color(0xff4E57CD), fontSize: 15),
                    )),
                onPressed: () {
                  widget.onBackTapped(0.8,0.1);
                },
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
                    child: const Text(
                      "créer votre compte",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => NavbarDoc()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
