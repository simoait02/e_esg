import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../api.dart';
import 'Cardi.dart';

class Resetpassword extends StatefulWidget {
  final Function(double, double) onBackTapped;
  final Function(double, double) onContinueTapped;

  Resetpassword({super.key, required this.onBackTapped, required this.onContinueTapped});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  bool passwordVisible = false;
  static TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  String? emailError;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  void validateEmail() {
    String email = emailController.text;
    if (email.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        emailError = 'Invalid email format';
      });
    } else {
      setState(() {
        emailError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height * 0.07,
            width: width * 0.7,
            child: AutoSizeText(
              appLocalizations!.forgotPassword.split("?")[0],
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                fontFamily: "poppins",
              ),
            ),
          ),
          SizedBox(height: height * 0.03),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              appLocalizations.resetText,
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Cardi.isDarkMode.value
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.email,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                ),
                Container(
                  height: 51,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isFocused
                          ? const Color(0xFF2E37A4)
                          : (Cardi.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : const Color(0xFFEAEBF6)),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: CupertinoTextField(
                    controller: emailController,
                    style: TextStyle(
                      color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                    ),
                    focusNode: focusNode,
                    autofocus: true,
                    cursorColor: const Color(0xFF2E37A4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 0),
                    ),
                    onTapOutside: (PointerDownEvent event) {
                      focusNode.unfocus();
                      validateEmail();
                    },
                  ),
                ),
                if (emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      emailError!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                SizedBox(height: height * 0.05),
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
                        widget.onBackTapped(0.55, 0.1);
                      },
                    ),
                    CupertinoButton(
                      child: Container(
                        width: width * 0.3,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff4E57CD), Color(0xff0c40a4)],
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          appLocalizations.suivant,
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      onPressed: () async {
                        validateEmail();
                        if (emailError == null) {
                          final url = Uri.parse("$Url/password/forgot");
                          Map<String, dynamic> data = {
                            "email": emailController.text,
                          };
                          try {
                            final response = await http.post(
                              url,
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: json.encode(data),
                            );

                            if (response.statusCode == 200) {
                              print('Data posted successfully: ${response.body}');
                              Fluttertoast.showToast(msg: response.body.toString(), backgroundColor: Colors.greenAccent,textColor: Colors.black);
                              widget.onContinueTapped(0.6, 0.25);
                            } else {
                              print('Failed to post data: ${response.statusCode}');
                              Fluttertoast.showToast(msg: response.body.toString(), backgroundColor: Colors.red);
                              print('Response body: ${response.body}');
                            }
                          } catch (e) {
                            Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
                            print('Error: $e');
                          }
                        } else {
                          Fluttertoast.showToast(msg: emailError.toString(), backgroundColor: Colors.red);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
