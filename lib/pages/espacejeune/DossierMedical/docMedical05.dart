import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SideBar/SidebarController.dart';
import 'DocMedical.dart';

class Docmedical05 extends StatefulWidget {
  const Docmedical05({super.key});

  @override
  State<Docmedical05> createState() => _Docmedical05State();
}

class _Docmedical05State extends State<Docmedical05> {
  bool boxCheck=false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.05),
         AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "1. Objet du Consentement: ",
            style: TextStyle(fontWeight: FontWeight.bold,color:isDarkMode? Colors.white:Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: "Vous consentez à ce que les informations que vous fournissez soient utilisées dans le cadre de votre consultation médicale et pour améliorer la qualité des soins médicaux.",
                style: TextStyle(fontWeight: FontWeight.normal,color:isDarkMode? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.8)),
              ),
            ],
          ),
        ),
         AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "2. Confidentialité des Données: ",
            style: TextStyle(fontWeight: FontWeight.bold,color:isDarkMode? Colors.white:Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: "Vos données personnelles seront traitées de manière confidentielle et ne seront partagées qu'avec les professionnels de santé impliqués dans votre prise en charge.",
                style: TextStyle(fontWeight: FontWeight.normal,color:isDarkMode? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.8)),
              ),
            ],
          ),
        ),
         AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "3. Droits des Patients: ",
            style: TextStyle(fontWeight: FontWeight.bold,color:isDarkMode? Colors.white:Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: "Vous avez le droit de demander l'accès, la rectification ou la suppression de vos données personnelles à tout moment. Vous pouvez également retirer votre consentement sans que cela n'affecte la légalité du traitement effectué avant le retrait.",
                style: TextStyle(fontWeight: FontWeight.normal,color:isDarkMode? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.8)),
              ),
            ],
          ),
        ),
         AutoSizeText.rich(
          maxLines: 3,
          TextSpan(
            text: "4. Utilisation des Données: ",
            style: TextStyle(fontWeight: FontWeight.bold,color:isDarkMode? Colors.white:Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: "Vos données peuvent être utilisées à des fins de recherche médicale et de développement de nouvelles thérapies, sous réserve de votre anonymat.",
                style: TextStyle(fontWeight: FontWeight.normal,color:isDarkMode? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.8)),
              ),
            ],
          ),
        ),
         AutoSizeText.rich(
          maxLines: 2,
          TextSpan(
            text: "5. Durée du Consentement: ",
            style: TextStyle(fontWeight: FontWeight.bold,color:isDarkMode? Colors.white:Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: "Ce consentement est valable jusqu'à ce que vous décidiez de le révoquer.",
                style: TextStyle(fontWeight: FontWeight.normal,color:isDarkMode? Colors.white.withOpacity(0.8):Colors.black.withOpacity(0.8)),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        Row(
          children: [
            Checkbox(
              value: boxCheck,
              onChanged: (value) {
                setState(() {
                  boxCheck = value!;
                });
              },
            ),
            const Expanded(
              child: AutoSizeText(
                maxLines: 1,
                "J'ai lue et J'accepte les termes et conditions.",
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.05,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              child: Container(
                width: width * 0.3,
                height: height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Color(0xff4E57CD)),
                ),
                alignment: Alignment.center,
                child: Text(
                  appLocalizations!.precedent,
                  style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                ),
              ),
              onPressed: () {
                DocMedical.setProgress(context, 0.75);
                DocMedical.setIndex(context, 2);
              },
            ),
            CupertinoButton(
              child: Container(
                width: width * 0.3,
                height: height * 0.05,
                decoration: BoxDecoration(
                  gradient: !boxCheck? const LinearGradient(
                      colors: [Color(0xff383839), Color(0xff444448)],
                      ):const LinearGradient(
                    colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: AutoSizeText(
                  appLocalizations.valide,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              onPressed: () async {
                SharedPreferences prefs=await SharedPreferences.getInstance();
                int? id=prefs.getInt("idYong");
                String? token=prefs.getString("token");
                if(boxCheck){
                  await api.post(
                      "${EndPoints.GetJeuneViaId}$id/antecedentsPersonnels",
                      headers: {"Authorization": "$token",},
                      data:{
                        "maladies": maladie,
                        "utiliseMedicaments": utiliseMedicament,
                        "medicaments": [
                          typeMedicaments
                        ],
                        "chirurgicaux": chirurgicaux,
                        "operationsChirurgicales": operationsChirurgicales,
                        "habitudes": habitudes,
                        "cigarettesParJour": cigarettesParJour,
                        "consommationAlcool": consomationAlcohol,
                        "tempsEcran": tempsEcran,
                      }
                      );
                  await api.post(
                    "${EndPoints.GetJeuneViaId}$id/antecedentsFamiliaux",
                    headers: {"Authorization": "$token",},
                    data: {
                      "maladiesFamiliales": maladiesFamiliales,
                      "typeAntFam": typeAntFam,
                      "autre": autre
                    }
                  );
                  api.patch(""
                      "${EndPoints.GetJeuneViaId}$id",
                    headers:{"Authorization": "$token",},
                    data: {
                    "isFirstAuth":false
                    }
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => SideBarController()),
                        (Route<dynamic> route) => false,
                  );
                }
                },
            ),
          ],
        ),
      ],
    );
  }
}
