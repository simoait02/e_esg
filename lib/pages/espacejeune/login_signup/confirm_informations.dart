import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmInformations extends StatefulWidget {
  final Function(double, double) onLoginTapped;
  final Function(double, double) onConfirmTapped;

  ConfirmInformations({
    Key? key,
    required this.onConfirmTapped,
    required this.onLoginTapped,
  }) : super(key: key);

  @override
  State<ConfirmInformations> createState() => _ConfirmInformationsState();
}

class _ConfirmInformationsState extends State<ConfirmInformations> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String convertToUpperCase(String word) {
    Map<String, String> specialCases = {
      "Aucun" : "AUCUN",
      "Primaire": "PRIMAIRE",
      "Supérieur": "SUPERIEUR",
      "Secondaire": "SECONDAIRE"
    };
    return specialCases[word] ?? word.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: height * 0.07,
                width: width,
                child: AutoSizeText(
                  "Confirmer vos informations",
                  style: TextStyle(
                      color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "poppins"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: height * 0.55,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1)),
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(width, appLocalizations!.sex, CardiJeune.value==2?"Homme":"Femme",CardiJeune.isDarkMode.value),
                      const SizedBox(height: 10),
                      buildInfoRow(width, appLocalizations.nom, CardiJeune.lastnameController.text,CardiJeune.isDarkMode.value),
                      const SizedBox(height: 10),
                      buildInfoRow(width, appLocalizations.prenom, CardiJeune.firstnameController.text,CardiJeune.isDarkMode.value),
                      const SizedBox(height: 10),
                      buildInfoRow(width, appLocalizations.birthDay, "${CardiJeune.selectedDateTime?.day}/${CardiJeune.selectedDateTime?.month}/${CardiJeune.selectedDateTime?.year}",CardiJeune.isDarkMode.value),
                      const SizedBox(height: 10),
                      buildInfoRow(width, appLocalizations.tele, CardiJeune.numteleController.text,CardiJeune.isDarkMode.value),
                      const SizedBox(height: 10),
                      buildInfoRow(width, appLocalizations.email, CardiJeune.emailController.text,CardiJeune.isDarkMode.value),
                      const SizedBox(height: 10),
                      if(CardiJeune.age>=16) buildInfoRow(width, "Cin", CardiJeune.cinController.text,CardiJeune.isDarkMode.value),
                      const SizedBox(height: 10),
                      if(CardiJeune.scolarity)
                        ...[
                          buildInfoRow(width, "Niveau d'etudes actuel", convertToUpperCase(CardiJeune.studActu),CardiJeune.isDarkMode.value),
                          const SizedBox(height: 10),
                          if(CardiJeune.studActu == 'Primaire')
                            buildInfoRow(width, "Code massar", CardiJeune.codemassarController.text,CardiJeune.isDarkMode.value)
                          else
                            buildInfoRow(width, "Cne", CardiJeune.cneController.text,CardiJeune.isDarkMode.value),
                        ]
                      else
                        ...[
                          buildInfoRow(width, "Dernier niveau d'etudes", CardiJeune.lastStud,CardiJeune.isDarkMode.value),
                          const SizedBox(height: 10),
                          buildInfoRow(width, "Situation actuelle", CardiJeune.stateActu,CardiJeune.isDarkMode.value),
                        ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Container(
                    width: width * 0.3,
                    height: height * 0.06,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: const Color(0xff4E57CD))),
                    alignment: Alignment.center,
                    child: Text(
                      appLocalizations.precedent,
                      style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                    )),
                onPressed: ()  {
                  widget.onLoginTapped(0.6, 0.1);


                },
              ),
              CupertinoButton(
                onPressed: (){
                  widget.onConfirmTapped(0.6, 0.1);
                },
                // onPressed: () async {
                //   if(CardiJeune.scolarity) {
                //     final url = Uri.parse("$Url/register/jeunes/scolarise");
                //     Map<String, dynamic> data = {
                //       "infoUser": {
                //         "nom": CardiJeune.lastnameController.text,
                //         "prenom": CardiJeune.firstnameController.text,
                //         "mail": CardiJeune.emailController.text,
                //         "numTel": CardiJeune.numteleController.text,
                //         "motDePasse": CardiJeune.passwordController.text
                //       },
                //       "sexe": CardiJeune.value==2?"MASCULIN":"FEMININ",
                //       "dateNaissance": CardiJeune.birthDay,
                //       "scolarise": true,
                //       "cin": CardiJeune.cinController.text,
                //       "niveauEtudeActuel": "SUPERIEUR",
                //       "cne": CardiJeune.cneController.text
                //     };
                //     try {
                //       final response = await http.post(
                //         url,
                //         headers: {
                //           'Content-Type': 'application/json',
                //         },
                //         body: json.encode(data),
                //       );
                //       if (response.statusCode == 200) {
                //         print('Data posted successfully: ${response.body}');
                //         widget.onConfirmTapped(0.6, 0.1);
                //       } else {
                //         print('Request data: ${json.encode(data)}');
                //         print('Failed to post data: ${response.statusCode}');
                //         Fluttertoast.showToast(msg: response.body.toString(), backgroundColor: Colors.red);
                //         print('Response body: ${response.body}');
                //       }
                //     } catch (e) {
                //       Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
                //       print('Error: $e');
                //     }
                //   }
                //   else {
                //     final url = Uri.parse("$Url/register/jeunes/scolarise");
                //     Map<String, dynamic> data = {
                //       "infoUser": {
                //         "nom":CardiJeune.lastnameController.text,
                //         "prenom": CardiJeune.firstnameController.text,
                //         "mail": CardiJeune.emailController.text,
                //         "numTel": CardiJeune.numteleController.text,
                //         "motDePasse": CardiJeune.passwordController.text
                //       },
                //       "sexe": CardiJeune.value==2?"MASCULIN":"FEMININ",
                //       "dateNaissance": "${CardiJeune.selectedDateTime?.year}-${CardiJeune.selectedDateTime?.month}-${CardiJeune.selectedDateTime?.day}",
                //       "scolarise": false,
                //       "cin":CardiJeune.cinController.text,
                //       "dernierNiveauEtudes": "SUPERIEUR",
                //       "enActivite": CardiJeune.stateActu=='En activité'
                //
                //     };
                //     try {
                //       final response = await http.post(
                //         url,
                //         headers: {
                //           'Content-Type': 'application/json',
                //         },
                //         body: json.encode(data),
                //       );
                //       if (response.statusCode == 200) {
                //         print('Data posted successfully: ${response.body}');
                //         widget.onConfirmTapped(0.6, 0.1);
                //       } else {
                //         print('Request data: ${json.encode(data)}');
                //         print('Failed to post data: ${response.statusCode}');
                //         Fluttertoast.showToast(
                //             msg: response.body.toString(), backgroundColor: Colors.red);
                //         print('Response body: ${response.body}');
                //       }
                //     } catch (e) {
                //       Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
                //       print('Error: $e');
                //     }
                //   }
                // },
                child: Container(
                    width: width * 0.4,
                    height: height * 0.06,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff4E57CD), Color(0xff0c40a4)]),
                        borderRadius: BorderRadius.circular(40)),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      appLocalizations.createAcc,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoRow(double width, String label, String value,bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.3,
          child: AutoSizeText(
            label,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 10,
              color:isDarkMode? const Color(0xff6998fd):const Color(0xFF2E37A4),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: AutoSizeText(
            value,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 10,
                color: isDarkMode? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.8)
            ),
          ),
        ),
      ],
    );
  }
}