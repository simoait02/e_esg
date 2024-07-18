import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/NavigationBarDoctor.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../IES/statistiques.dart';


class Password extends StatefulWidget {
  final Function(double,double) onBackTapped;

  Password({super.key, required this.onBackTapped});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool passwordvisible=false;
  bool passwordvisible2=false;

  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  FocusNode _focusNode2 = FocusNode();
  bool _isFocused2 = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  void _showPassword(){
    setState(() {
      passwordvisible=!passwordvisible;
      if(_isFocused) _isFocused=true;
    });
  }
  void _showPassword2(){
    setState(() {
      passwordvisible2=!passwordvisible2;
      if(_isFocused2) _isFocused2=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height*0.07,
            width: width*0.7,
            child:  Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                appLocalizations!.createPass,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Cardi.isDarkMode.value?Colors.white:Colors.black,
                    fontFamily: "poppins"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.password,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: titleFontSize+15,
                    color: Cardi.isDarkMode.value?Colors.white:Colors.black,
                  ),
                ),
                Container(
                  height: 51,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isFocused ? Color(0xFF2E37A4) : Cardi.isDarkMode.value ? CupertinoColors.white : Color(0xFFEAEBF6),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          style:TextStyle(
                            color: Cardi.isDarkMode.value?Colors.white:Colors.black,
                          ),
                          focusNode: _focusNode,
                          autofocus: false,
                          obscureText: !passwordvisible,
                          cursorColor: Color(0xFF2E37A4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 0),
                          ),
                          onTapOutside: (PointerDownEvent event) {
                            _focusNode.unfocus();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: _showPassword,
                        highlightColor: Colors.transparent,
                        icon: Container(
                          width: iconButtonSize+30,
                          height: iconButtonSize+30,
                          child:passwordvisible? Image.asset('assets/images/invisible.png'):Image.asset('assets/images/visible.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/images/warning.svg",color: Color(0xff59E2DB),),
                Expanded(child: Text(
                  "the password should be atleast 8 characters and  contain both lowercase and uppercase letters and  at least one numerical character and  special characters (! @ # % ^ & * )",style: TextStyle(fontSize: 10,color: Color(0xff9999A3)),
                ))
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.confirmPass,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: titleFontSize+15,
                    color: Cardi.isDarkMode.value?Colors.white:Colors.black,
                  ),
                ),
                Container(
                  height: 51,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isFocused2? Color(0xFF2E37A4) : Cardi.isDarkMode.value ? CupertinoColors.white : Color(0xFFEAEBF6),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          style:TextStyle(
                            color: Cardi.isDarkMode.value?Colors.white:Colors.black,
                          ),
                          focusNode: _focusNode2,
                          autofocus: false,
                          obscureText: !passwordvisible2,
                          cursorColor: Color(0xFF2E37A4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 0),
                          ),
                          onTapOutside: (PointerDownEvent event) {
                            _focusNode2.unfocus();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: _showPassword2,
                        highlightColor: Colors.transparent,
                        icon: Container(
                          width: iconButtonSize+30,
                          height: iconButtonSize+30,
                          child:passwordvisible2? Image.asset('assets/images/invisible.png'):Image.asset('assets/images/visible.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                    width: width * 0.3,
                    height: height*0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Color(0xff4E57CD))),
                    alignment: Alignment.center,
                    child: Text(
                      appLocalizations.precedent,
                      style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                    )),
                onPressed: () {
                  widget.onBackTapped(0.5,0.1);
                },
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => NavbarDoc()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                    width: width * 0.4,
                    height: height*0.06,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff4E57CD), Color(0xff0c40a4)]),
                        borderRadius: BorderRadius.circular(40)),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      appLocalizations.createAcc,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
                /**/
              ),
            ],
          ),
        ],
      ),
    );
  }
}
