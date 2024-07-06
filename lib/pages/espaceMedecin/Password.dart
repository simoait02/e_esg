import 'package:e_esg/pages/IES/calendrier.dart';
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

  Widget buildLabel(String label) {
    return Container(
      margin: const EdgeInsets.only(left: 40, top: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(fontFamily: "Inter", fontSize: 15),
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
    return SingleChildScrollView(

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
            margin: EdgeInsets.only(left: 30),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "créer un mot de passe",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "poppins"),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          buildLabel("mot de passe"),
          const SizedBox(height: 5,),
          buildTextField(width, "", _coPasswordFocusNode, _coPasswordHasFocus),
          const SizedBox(height: 10,),
          buildLabel("confirmer mot de passe"),
          const SizedBox(height: 5,),
          buildTextField(width, "", _passwordFocusNode, _passwordHasFocus),
          const SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                    width: width * 0.3,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Color(0xff0b40ff))),
                    alignment: Alignment.center,
                    child: const Text(
                      "Precedent",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
                onPressed: () {
                  widget.onBackTapped(0.7,0.1);
                },
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
                    child: const Text(
                      "créer votre compte",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Calendrier()));
                },
              ),
            ],
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
