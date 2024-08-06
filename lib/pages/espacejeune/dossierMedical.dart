import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/SideBar/Settings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../api/end_points.dart';
import '../../api/errors/Exceptions.dart';
import 'login_signup/Cardi.dart';

class Dossiermedical extends StatefulWidget {
  const Dossiermedical({super.key});

  @override
  State<Dossiermedical> createState() => DossiermedicalState();
}

class DossiermedicalState extends State<Dossiermedical> {
  int selectedIndex = 0;
  Map<String, String> infos = {};

  void fillInfos(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    infos = {
      appLocalizations!.nom: "",
      appLocalizations.prenom: "",
      appLocalizations.sex: "",
      appLocalizations.birthDay: "",
      appLocalizations.email: "",
      appLocalizations.tele: "",
      appLocalizations.antecedentsMedicaux: "De 10/07/2023 a 24/07/2024 \n -hépatique \n -fievre",
      appLocalizations.antecedentsChirurgicaux: "Oui",
      appLocalizations.antecedentsFamiliaux: "tttt",
    };
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      SettingsYong.isSystemSettings = prefs.getBool('isSystemSettingsYong') ?? true;
      SettingsYong.isDark = prefs.getBool('isDarkYong') ?? false;
      SettingsYong.isLight = prefs.getBool('isLightYong') ?? false;
      SettingsYong.isDarkMode.value = prefs.getBool('isDarkModeYong') ?? (MediaQuery.of(context).platformBrightness == Brightness.dark);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        fillInfos(context);
      });
    });
    _fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fillInfos(context);
    _fetchData();
  }

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final appLocalizations = AppLocalizations.of(context);
    if (token != null) {
      print("Token: $token");
      Map<String, dynamic> decodedToken;
      try {
        decodedToken = JwtDecoder.decode(token);
        print("Decoded Token: $decodedToken");
      } catch (e) {
        print("Token decoding error: $e");
        Fluttertoast.showToast(msg: "Invalid token", backgroundColor: Colors.red);
        return;
      }
      if (decodedToken.containsKey('claims') && decodedToken['claims'].containsKey('id')) {
        try {
          final get = await api.get(
            EndPoints.GetJeuneViaId + decodedToken['claims']['id'].toString(),
            headers: {
              "Authorization": token
            },
          );

          setState(() {
            infos[appLocalizations!.nom] = get["nom"];
            infos[appLocalizations.prenom] = get["prenom"];
            infos[appLocalizations.sex] = get["sexe"];
            infos[appLocalizations.birthDay] = get["dateNaissance"];
            infos[appLocalizations.email] = get["mail"];
            infos[appLocalizations.tele] = get["numTele"];
            if (get['age'] >= 16) {
              infos.addEntries([MapEntry("CIN", get["cin"] ?? "")]);
            }
            if (!get.containsKey("enActivite")) {
              infos.addEntries([MapEntry("Niveau d'études actuel", get["niveauEtudesActuel"])]);
              if (get['codeMASSAR'] != null) {
                infos.addEntries([MapEntry("Code massar", get['codeMASSAR'])]);
              } else {
                infos.addEntries([MapEntry("Cne", get['cne'] ?? "")]);
              }
            } else {
              infos.addEntries([MapEntry("Dernier niveau d'études", get["dernierNiveauEtudes"])]);
              infos.addEntries([MapEntry("En activité", get["enActivite"] ? "OUI" : "NON")]);
            }
          });
        } on ServerException catch (e) {
          Fluttertoast.showToast(msg: e.errormodel.errorMsg, backgroundColor: Colors.red);
        }
      } else {
        print("Invalid token structure");
        Fluttertoast.showToast(msg: "Invalid token structure", backgroundColor: Colors.red);
      }
    } else {
      print("Token is null");
      Fluttertoast.showToast(msg: "Token is null", backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                Container(
                  width: screenWidth * 1,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('Changer la photo de profil');
                        },
                        child: CircleAvatar(
                          radius: screenWidth * 0.15,
                          backgroundImage: AssetImage('assets/images/boy.png'),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: infos.length,
                        separatorBuilder: (context, index) => Divider(
                          color: SettingsYong.isDarkMode.value ? Color(0xff545456) : Color(0x56545456),
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          String key = infos.keys.elementAt(index);
                          String value = infos[key]!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenWidth * 0.3,
                                  child: AutoSizeText(
                                    maxLines: 2,
                                    "$key ",
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.05,),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.aBeeZee(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
