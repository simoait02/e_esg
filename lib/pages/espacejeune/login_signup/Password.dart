import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../IES/statistiques.dart';
import 'Cardi.dart';

class Password extends StatefulWidget {
  final Function(double,double) onBackTapped;
  final Function(double,double) onCreateTapped;

  Password({super.key, required this.onBackTapped, required this.onCreateTapped});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool passwordvisible=false;
  bool passwordvisible2=false;
  bool passwordwrong=false;
  bool isnotconfirmed=false;
  TextEditingController confirmpasswordController=TextEditingController();
  String errorText="";

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
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height*0.07,
            width: width*0.7,
            child:  AutoSizeText(
              appLocalizations!.createPass,
              maxLines: 2,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: CardiJeune.isDarkMode.value?Colors.white:Colors.black,
                  fontFamily: "poppins"),
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
              color: CardiJeune.isDarkMode.value?Colors.white:Colors.black,
            ),
          ),
          Container(
            height: 51,
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isFocused
                    ? Color(0xFF2E37A4)
                    : passwordwrong
                    ? Colors.red
                    : CardiJeune.isDarkMode.value
                    ? CupertinoColors.white.withOpacity(0.5)
                    : Color(0xFFEAEBF6),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller:CardiJeune.passwordController,
                    style:TextStyle(
                      color: CardiJeune.isDarkMode.value?Colors.white:Colors.black,
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
                    color: CardiJeune.isDarkMode.value?Colors.white:Colors.black,
                  ),
                ),
                Container(
                  height: 51,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _isFocused2
                          ? Color(0xFF2E37A4)
                          : isnotconfirmed
                          ? Colors.red
                          : CardiJeune.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : Color(0xFFEAEBF6),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller:confirmpasswordController,
                          style:TextStyle(
                            color: CardiJeune.isDarkMode.value?Colors.white:Colors.black,
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
          Visibility(
            visible: (passwordwrong||isnotconfirmed),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(child:AutoSizeText(
                errorText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              )),
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
                  final password=CardiJeune.passwordController.text;
                  final confirmpassword=confirmpasswordController.text;
                  setState(() {
                    passwordwrong = !RegExp(r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d)[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,16}$').hasMatch(password);
                    isnotconfirmed=password!=confirmpassword;
                    if (passwordwrong||isnotconfirmed) {
                      errorText = "le mot de passe n'est pas validé";
                    } else {
                      errorText = "";
                    }});
                  if (!(passwordwrong||isnotconfirmed)){
                    widget.onCreateTapped(0.8,0.1);
                  }
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
                /*Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => NavbarDoc()),
                        (Route<dynamic> route) => false,
                  );*/
              ),
            ],
          ),
        ],
      ),
    );
  }
}
