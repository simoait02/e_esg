import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../LoginSignUp/Cardi.dart';
class Voirdossiermedical extends StatefulWidget {
  const Voirdossiermedical({super.key});

  @override
  State<Voirdossiermedical> createState() => _VoirdossiermedicalState();
}

class _VoirdossiermedicalState extends State<Voirdossiermedical> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    dynamic patient = ModalRoute.of(context)!.settings.arguments as dynamic;
    Map<String, String> infos = {
      "Nom": patient["infoUser"]["nom"],
      "Prenom": patient["infoUser"]["prenom"],
      "sexe": patient["sexe"],
      "dateNaissance": patient["dateNaissance"],
      "age": patient["age"].toString(),
      "Maladies Familiales": (patient["dossierMedial"]["antecedentsFamiliaux"][0]["maladiesFamiliales"].length==0)?"Aucun":patient["dossierMedial"]["antecedentsFamiliaux"][0]["maladiesFamiliales"].join("\n"),
      if(patient["dossierMedial"]["antecedentsFamiliaux"][0]["typeAntFam"]!="")"type d'antecedents familiaux": patient["dossierMedial"]["antecedentsFamiliaux"][0]["typeAntFam"],
      if(patient["dossierMedial"]["antecedentsFamiliaux"][0]['autre']!="")"autre antecedents familiaux": patient["dossierMedial"]["antecedentsFamiliaux"][0]['autre'],
      "maladies": (patient["dossierMedial"]["antecedentsPersonnels"][0]["maladies"].length==0)?"Aucun":patient["dossierMedial"]["antecedentsPersonnels"][0]["maladies"].join("\n"),
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["utiliseMedicaments"]) "Medicaments": patient["dossierMedial"]["antecedentsPersonnels"][0]["medicaments"].join("\n"),
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["chirurgicaux"]) "Operations Chirurgicales": patient["dossierMedial"]["antecedentsPersonnels"][0]["operationsChirurgicales"],
      "Habitudes": (patient["dossierMedial"]["antecedentsPersonnels"][0]["habitudes"].length==0)?"Aucune":patient["dossierMedial"]["antecedentsPersonnels"][0]["habitudes"].join("\n"),
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["cigarettesParJour"]!=0)"Cigarettes par jour": patient["dossierMedial"]["antecedentsPersonnels"][0]["cigarettesParJour"].toString(),
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["consommationAlcool"]!=null) "Consommation d'alcool":  patient["dossierMedial"]["antecedentsPersonnels"][0]["consommationAlcool"],
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["tempsEcran"]!="") "Temps passé devant l'ecran": patient["dossierMedial"]["antecedentsPersonnels"][0]["tempsEcran"],
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["dureeFumee"]!=null) "dureeFumee": patient["dossierMedial"]["antecedentsPersonnels"][0]["dureeFumee"],
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["type"]!=null)"type": patient["dossierMedial"]["antecedentsPersonnels"][0]["type"],
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["specification"]!=null)"specification": patient["dossierMedial"]["antecedentsPersonnels"][0]["specification"],
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["specificationAutre"]!=null)"specificationAutre": patient["dossierMedial"]["antecedentsPersonnels"][0]["specificationAutre"],
      if(patient["dossierMedial"]["antecedentsPersonnels"][0]["nombreAnnee "]!=null)"nombreAnnee": patient["dossierMedial"]["antecedentsPersonnels"][0]["nombreAnnee "].toString(),
      if(patient["dossierMedial"]["historiqueConsultations"].length!=0)"Historique de consultation":patient["dossierMedial"]["historiqueConsultations"].join("\n")
    };
    final width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context)!;

    bool isArabic(BuildContext context) {
      return Localizations.localeOf(context).languageCode == 'ar';
    }
    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              Container(
                width: width,
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Changer la photo de profil');
                      },
                      child: CircleAvatar(
                        radius: width * 0.15,
                        backgroundImage: const AssetImage("assets/images/patient.png"),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: infos.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Cardi.isDarkMode.value ? const Color(0xff545456) : const Color(0x56545456),
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
                              SizedBox(
                                width: width * 0.3,
                                child: AutoSizeText(
                                  maxLines: 2,
                                  "$key ",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.05,),
                              Expanded(
                                child: Text(
                                  value,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
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
            ],
          ),
        ),
      ),
    );
  }
}
