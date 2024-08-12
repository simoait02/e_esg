
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/SideBar/Settings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../api/end_points.dart';
import '../../api/errors/Exceptions.dart';

class Dossiermedical extends StatefulWidget {
  const Dossiermedical({super.key});

  @override
  State<Dossiermedical> createState() => DossiermedicalState();
}

class DossiermedicalState extends State<Dossiermedical> {
  int selectedIndex = 0;
  Map<String, String> infos = {};

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
      _fetchData();
    });
  }

  Map<String, String> data = {};

  Future<void> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? id = prefs.getInt("idYong");
    try {
      final get = await api.get(
        "${EndPoints.GetJeuneViaId}$id",
        headers: {
          "Authorization": token
        },
      );

      setState(() {
        data["nom"] = get["nom"];
        data["prenom"] = get["prenom"];
        data["sex"] = get["sexe"];
        data["birthDay"] = get["dateNaissance"];
        data["email"] = get["mail"];
        data["tele"] = get["numTele"];
        if (get['age'] >= 16) {
          data["CIN"] = get["cin"] ?? "";
        }
        if (!get.containsKey("enActivite")) {
          data["Niveau d'études actuel"] = get["niveauEtudesActuel"];
          if (get['codeMASSAR'] != null) {
            data["Code massar"] = get['codeMASSAR'];
          } else {
            data["Cne"] = get['cne'] ?? "";
          }
        } else {
          data["Dernier niveau d'études"] = get["dernierNiveauEtudes"];
          data["En activité"] = get["enActivite"] ? "OUI" : "NON";
        }
      });
    } on ServerException catch (e) {
      Fluttertoast.showToast(msg: e.errormodel.errorMsg, backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);

    infos = {
      appLocalizations!.nom: data["nom"] ?? "",
      appLocalizations.prenom: data["prenom"] ?? "",
      appLocalizations.sex: data["sex"] ?? "",
      appLocalizations.birthDay: data["birthDay"] ?? "",
      appLocalizations.email: data["email"] ?? "",
      appLocalizations.tele: data["tele"] ?? "",
    };

    if (data.containsKey("CIN")) infos["CIN"] = data["CIN"]!;
    if (data.containsKey("Niveau d'études actuel")) infos["Niveau d'études actuel"] = data["Niveau d'études actuel"]!;
    if (data.containsKey("Code massar")) infos["Code massar"] = data["Code massar"]!;
    if (data.containsKey("Cne")) infos["CNE"] = data["Cne"]!;
    if (data.containsKey("Dernier niveau d'études")) infos["Dernier niveau d'études"] = data["Dernier niveau d'études"]!;
    if (data.containsKey("En activité")) infos["En activité"] = data["En activité"]!;

    return Scaffold(
      backgroundColor: SettingsYong.isDarkMode.value ? const Color(0xff141218) : const Color(0xffF5F5F6),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Changer la photo de profil');
                      },
                      child: CircleAvatar(
                        radius: screenWidth * 0.15,
                        backgroundImage: const AssetImage('assets/images/boy.png'),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: infos.length,
                      separatorBuilder: (context, index) => Divider(
                        color: SettingsYong.isDarkMode.value ? const Color(0xff545456) : const Color(0x56545456),
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
                                    textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
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
                                      color: SettingsYong.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
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
              const SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}
