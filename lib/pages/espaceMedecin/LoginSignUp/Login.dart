import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/NavigationBarDoctor.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Widget buildLabel(String label, double height, bool isDarkMode) {
    return Container(
      margin: EdgeInsets.only(left: 40, top: height),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AutoSizeText(
          label,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildTextField(double width, double height, String placeholder, FocusNode focusNode, bool hasFocus, bool isDarkMode) {
    return SizedBox(
      width: width * 0.8,
      height: height * 0.055,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoTextField(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDarkMode
                  ? (hasFocus ? CupertinoColors.systemBlue : CupertinoColors.white.withOpacity(0.5))
                  : (hasFocus ? Color(0xFF2E37A4) : Color(0xFFEAEBF6)),
              width: 2,
            ),
          ),
          focusNode: focusNode,
          onTapOutside: (event) => setState(() {
            focusNode.unfocus();
          }),
          placeholder: placeholder,
          placeholderStyle: TextStyle(
            color: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
          ),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      )

    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
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
                child: AutoSizeText(
                  appLocalizations!.login,
                  style: TextStyle(
                    color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "poppins",
                  ),
                ),
              ),
            ),
          ),
          buildLabel(appLocalizations.id, height * 0.02, Cardi.isDarkMode.value),
          const SizedBox(height: 5),
          buildTextField(width, height, "E-mail, CIN", _emailFocusNode, _emailHasFocus, Cardi.isDarkMode.value),
          buildLabel(appLocalizations.password, height * 0.02, Cardi.isDarkMode.value),
          const SizedBox(height: 5),
          buildTextField(width, height, "", _passwordFocusNode, _passwordHasFocus, Cardi.isDarkMode.value),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Row(
              children: [
                Spacer(),
                GestureDetector(
                  child: AutoSizeText(
                    appLocalizations.forgotPassword,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.04,
                      fontFamily: "Poppins",
                      color: Color(0xff00D3C7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            child: Container(
              width: width * 0.3,
              height: height * 0.05,
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              alignment: Alignment.center,
              child: AutoSizeText(
                AppLocalizations.of(context)!.login,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => NavbarDoc()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: height * 0.04,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                AutoSizeText(
                  appLocalizations.needAcc,
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Cardi.isDarkMode.value ? Colors.white : Color(0xff9999A3),
                  ),
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    widget.onSignUpTapped(0.8, 0.1);
                  },
                  child: AutoSizeText(
                    appLocalizations.signUp,
                    style: TextStyle(
                      fontFamily: "Inter",
                      color: Cardi.isDarkMode.value ? Color(0xff759cd8) : Color(0xff3a01de),
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
