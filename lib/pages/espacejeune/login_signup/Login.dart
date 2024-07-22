import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/NavigationBarJeune.dart';
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
  bool remember = false;
  bool identifiernull = false;
  bool passwordnull = false;

  static final TextEditingController _identifierController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();

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
      margin: EdgeInsets.only(left: 10, top: height, right: 10),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 15,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget buildTextField(
      double width,
      double height,
      String placeholder,
      TextEditingController controller,
      FocusNode focusNode,
      bool hasFocus,
      bool isDarkMode,
      bool error) {
    return SizedBox(
      width: width * 0.8,
      height: height * 0.055,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoTextField(
          controller: controller,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: hasFocus
                  ? Color(0xFF2E37A4)
                  : error
                  ? Colors.red
                  : isDarkMode
                  ? CupertinoColors.white.withOpacity(0.5)
                  : Color(0xFFEAEBF6),
              width: 2,
            ),
          ),
          focusNode: focusNode,
          onTapOutside: (event) => setState(() {
            focusNode.unfocus();
          }),
          placeholder: placeholder,
          placeholderStyle: TextStyle(
            color: isDarkMode
                ? Colors.white.withOpacity(0.5)
                : Colors.black.withOpacity(0.5),
          ),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Container(
                height: height * 0.07,
                child: AutoSizeText(
                  appLocalizations!.login,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "poppins",
                  ),
                ),
              ),
            ),
            buildLabel(appLocalizations.id, height * 0.02, isDarkMode),
            buildTextField(
              width,
              height,
              "E-mail, CIN, CNE, Code Massar",
              _identifierController,
              _emailFocusNode,
              _emailHasFocus,
              isDarkMode,
              identifiernull,
            ),
            buildLabel(appLocalizations.password, height * 0.02, isDarkMode),
            buildTextField(
              width,
              height,
              "",
              _passwordController,
              _passwordFocusNode,
              _passwordHasFocus,
              isDarkMode,
              passwordnull,
            ),
            SizedBox(height: height * 0.01),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerRight,
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
            ),
            Align(
              alignment: Alignment.center,
              child: CupertinoButton(
                child: Container(
                  width: width * 0.4,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    appLocalizations.login,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onPressed: () {
                  final identifier = _identifierController.text;
                  final password = _passwordController.text;

                  setState(() {
                    identifiernull = identifier.isEmpty;
                    passwordnull = password.isEmpty;
                  });

                  if (!identifiernull && !passwordnull) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavbarYouth(
                          isSideBarClosed: false,
                          onSidebarToggle: () {},
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: height * 0.04,
              width: width * 0.9,
              child: Wrap(
                children: [
                  AutoSizeText(
                    appLocalizations.needAcc,
                    style: TextStyle(
                      fontFamily: "Inter",
                      color: Color(0xff9999A3),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
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
                        color: isDarkMode
                            ? Color(0xff759cd8)
                            : Color(0xff3a01de),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
