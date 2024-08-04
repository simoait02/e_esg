import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/api/errors/Exceptions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';


class Newpassword extends StatefulWidget {
  final Function(double, double) onBackTapped;
  final Function(double, double) onValidTrapped;

  Newpassword({super.key, required this.onBackTapped, required this.onValidTrapped});

  @override
  State<Newpassword> createState() => _NewpasswordState();
}

class _NewpasswordState extends State<Newpassword> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController = TextEditingController();
  static TextEditingController tokenController = TextEditingController();

  FocusNode tokenFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool error = false;

  @override
  void initState() {
    super.initState();
    tokenFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
    confirmPasswordFocusNode.addListener(() {
      setState(() {});
    });

    passwordController.addListener(() {
      setState(() {});
    });
    confirmPasswordController.addListener(() {
      setState(() {});
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      confirmPasswordVisible = !confirmPasswordVisible;
    });
  }

  bool validatePassword(String password) {
    return password.length >= 6 && RegExp(r'\d').hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.05,
            width: width * 0.7,
            child: AutoSizeText(
              appLocalizations!.createPass,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                fontFamily: "poppins",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Token",
                  style: GoogleFonts.poppins(fontSize: 16, color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                ),
                Container(
                  alignment: Alignment.center ,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: tokenFocusNode.hasFocus
                          ? const Color(0xFF2E37A4)
                          : (Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : const Color(0xFFEAEBF6)),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CupertinoTextField(
                    controller: tokenController,
                    style: TextStyle(
                      color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                    ),
                    focusNode: tokenFocusNode,
                    cursorColor: const Color(0xFF2E37A4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 0),
                    ),
                    onTapOutside: (PointerDownEvent event) {
                      tokenFocusNode.unfocus();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height*0.02,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  appLocalizations.password,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: passwordFocusNode.hasFocus
                          ? (validatePassword(passwordController.text) ? Colors.green : Colors.red)
                          : (Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : const Color(0xFFEAEBF6)),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: passwordController,
                          style: TextStyle(
                            color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                          ),
                          focusNode: passwordFocusNode,
                          obscureText: !passwordVisible,
                          cursorColor: const Color(0xFF2E37A4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 0),
                          ),
                          onTapOutside: (PointerDownEvent event) {
                            passwordFocusNode.unfocus();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: togglePasswordVisibility,
                        highlightColor: Colors.transparent,
                        icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
                      ),
                    ],
                  ),
                ),
                if (!validatePassword(passwordController.text) && passwordController.text.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Password must be at least 6 characters long and include at least one digit.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
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
                SvgPicture.asset(
                  "assets/images/warning.svg",
                  color: const Color(0xff59E2DB),
                ),
                const Expanded(
                  child: Text(
                    "The password should be at least 6 characters long and contain at least one numerical character.",
                    style: TextStyle(fontSize: 10, color: Color(0xff9999A3)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  appLocalizations.confirmPass,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: error
                          ? Colors.red
                          : Cardi.isDarkMode.value
                          ? (confirmPasswordFocusNode.hasFocus ? const Color(0xFF2E37A4) : CupertinoColors.white.withOpacity(0.5))
                          : (confirmPasswordFocusNode.hasFocus ? const Color(0xFF2E37A4) : const Color(0xFFEAEBF6)),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: confirmPasswordController,
                          style: TextStyle(
                            color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                          ),
                          focusNode: confirmPasswordFocusNode,
                          obscureText: !confirmPasswordVisible,
                          cursorColor: const Color(0xFF2E37A4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent, width: 0),
                          ),
                          onTapOutside: (PointerDownEvent event) {
                            confirmPasswordFocusNode.unfocus();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: toggleConfirmPasswordVisibility,
                        highlightColor: Colors.transparent,
                        icon: Icon(confirmPasswordVisible ? Icons.visibility_off : Icons.visibility),
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
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xff4E57CD)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    appLocalizations.precedent,
                    style: const TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                  ),
                ),
                onPressed: () {
                  widget.onBackTapped(0.5, 0.1);
                },
              ),
              CupertinoButton(

                onPressed: () async {
                  if (passwordController.text == confirmPasswordController.text) {
                    if (validatePassword(passwordController.text)) {
                      try {
                        final response=await api.post(
                          EndPoints.ResetPass,
                          data:{
                            "token": tokenController.text,
                            "newPassword": passwordController.text
                          },
                        );
                        Fluttertoast.showToast(msg: response,backgroundColor: Colors.greenAccent,textColor: Colors.black);
                        widget.onValidTrapped(0.55,0.25);
                      } on ServerException catch (e) {
                        print("dfffffffffffffffffffffffffffffffffffffffffffffffffffff");
                        Fluttertoast.showToast(msg: e.errormodel.errorMsg,backgroundColor: Colors.red);
                      }
                      // final url = Uri.parse("$Url/password/reset");
                      //
                      // Map<String, dynamic> data = {
                      //   "token": tokenController.text,
                      //   "newPassword": passwordController.text
                      // };
                      //
                      // try {
                      //   final response = await http.post(
                      //     url,
                      //     headers: {
                      //       'Content-Type': 'application/json',
                      //     },
                      //     body: json.encode(data),
                      //   );
                      //
                      //   if (response.statusCode == 200) {
                      //     print('Data posted successfully: ${response.body}');
                      //     Fluttertoast.showToast(msg: response.body.toString(), backgroundColor: Colors.greenAccent,textColor: Colors.black);
                      //     widget.onValidTrapped(0.55,0.25);
                      //   } else {
                      //     print('Failed to post data: ${response.statusCode}');
                      //     Fluttertoast.showToast(msg: response.body.toString(), backgroundColor: Colors.red);
                      //     print('Response body: ${response.body}');
                      //   }
                      // } catch (e) {
                      //   Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
                      //   print('Error: $e');
                      // }
                    } else {
                      setState(() {
                        error = true;
                      });
                      Fluttertoast.showToast(msg: "Password does not meet the criteria", backgroundColor: Colors.red);
                    }
                  } else {
                    setState(() {
                      error = true;
                    });
                    Fluttertoast.showToast(msg: "Passwords do not match", backgroundColor: Colors.red);
                  }
                },
                child: Container(
                  width: width * 0.4,
                  height: height * 0.06,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    appLocalizations.resetPass,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
