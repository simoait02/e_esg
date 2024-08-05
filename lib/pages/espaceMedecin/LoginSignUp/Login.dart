import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:e_esg/Widgets/NavigationBarDoctor.dart';
import 'package:e_esg/api/Dio_Consumer.dart';
import 'package:e_esg/api/api_Comsumer.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/api/errors/Exceptions.dart';
import 'package:e_esg/models/SignIn_modelDoc.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final Function(double, double) onSignUpTapped;
  final Function(double, double) onRestPassTapped;

  Login({super.key, required this.onSignUpTapped, required this.onRestPassTapped});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _emailHasFocus = false;
  bool _passwordHasFocus = false;
  bool identifiernull = false;
  bool passwordnull = false;
  final ApiComsumer api=DioConsumer(dio: Dio());
  static TextEditingController _identifierController = TextEditingController();
  static TextEditingController _passwordController = TextEditingController();
  SigninModeldoc? userDoc;

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
      margin: EdgeInsets.only(left: 40, top: height, right: 40),
      child: AutoSizeText(
        label,
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 15,
          color: isDarkMode ? Colors.white : null,
        ),
      ),
    );
  }

  Widget buildTextField(double width, double height, String placeholder, TextEditingController controller, FocusNode focusNode, bool hasFocus, bool isDarkMode, bool error) {
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
              color: hasFocus ? const Color(0xFF2E37A4) : error ? Colors.red : isDarkMode ? CupertinoColors.white.withOpacity(0.5) : const Color(0xFFEAEBF6),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
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
          buildLabel(appLocalizations.id, height * 0.02, Cardi.isDarkMode.value),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: buildTextField(width, height, "E-mail, CIN", _identifierController, _emailFocusNode, _emailHasFocus, Cardi.isDarkMode.value, identifiernull),
          ),
          buildLabel(appLocalizations.password, height * 0.02, Cardi.isDarkMode.value),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: buildTextField(width, height, "Password", _passwordController, _passwordFocusNode, _passwordHasFocus, Cardi.isDarkMode.value, passwordnull),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: GestureDetector(
              onTap: () { widget.onRestPassTapped(0.5, 0.25);},
              child: AutoSizeText(
                appLocalizations.forgotPassword,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.04,
                  fontFamily: "Poppins",
                  color: const Color(0xff00D3C7),
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
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              onPressed: () async {
                final identifier = _identifierController.text;
                final password = _passwordController.text;
                if (identifier.isEmpty || password.isEmpty) {
                  setState(() {
                    identifiernull = identifier.isEmpty;
                    passwordnull = password.isEmpty;
                  });
                } else {
                  try {
                    final response =await api.post(
                      EndPoints.LoginMedecin,
                      data:{
                        "username": _identifierController.text,
                        "password": _passwordController.text
                      },                          headers: {}

                    );
                    userDoc=SigninModeldoc.fromJson(response);
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('tokenDoc', "Bearer ${userDoc!.token}");
                    final decodedToken= JwtDecoder.decode(userDoc!.token);
                    print(decodedToken);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context)=>NavbarDoc()),
                          (Route<dynamic> route) => false,);
                  } on ServerException catch (e) {
                    print("dfffffffffffffffffffffffffffffffffffffffffffffffffffff");
                    Fluttertoast.showToast(msg: e.errormodel.errorMsg,backgroundColor: Colors.red);
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: height * 0.04,
            child: Wrap(
              children: [
                const SizedBox(width: 20),
                AutoSizeText(
                  appLocalizations.needAcc,
                  style: TextStyle(fontFamily: "Inter", color: Cardi.isDarkMode.value ? Colors.white : Colors.black, fontSize: 10),
                ),
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    widget.onSignUpTapped(0.75, 0.1);
                  },
                  child: AutoSizeText(
                    appLocalizations.signUp,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 10,
                      color: Cardi.isDarkMode.value ? const Color(0xff759cd8) : const Color(0xff3a01de),
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