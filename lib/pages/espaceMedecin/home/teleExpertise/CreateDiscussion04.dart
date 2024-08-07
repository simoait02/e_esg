import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addMeeting.dart';
import 'teleExpertise_Entry.dart';


class Creatediscussion04 extends StatefulWidget {

  Creatediscussion04({super.key});

  @override
  State<Creatediscussion04> createState() => _Creatediscussion04State();
}

class _Creatediscussion04State extends State<Creatediscussion04> {
  bool boxCheck=false;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.05),
        const AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "1. Objet du Consentement: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vous consentez à ce que les informations que vous fournissez soient utilisées dans le cadre de votre consultation médicale et pour améliorer la qualité des soins médicaux.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "2. Confidentialité des Données: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vos données personnelles seront traitées de manière confidentielle et ne seront partagées qu'avec les professionnels de santé impliqués dans votre prise en charge.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 4,
          TextSpan(
            text: "3. Droits des Patients: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vous avez le droit de demander l'accès, la rectification ou la suppression de vos données personnelles à tout moment. Vous pouvez également retirer votre consentement sans que cela n'affecte la légalité du traitement effectué avant le retrait.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 3,
          TextSpan(
            text: "4. Utilisation des Données: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Vos données peuvent être utilisées à des fins de recherche médicale et de développement de nouvelles thérapies, sous réserve de votre anonymat.",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        const AutoSizeText.rich(
          maxLines: 2,
          TextSpan(
            text: "5. Durée du Consentement: ",
            style: TextStyle(fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: "Ce consentement est valable jusqu'à ce que vous décidiez de le révoquer.",
                style: TextStyle(fontWeight: FontWeight.normal),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CupertinoButton(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xff4E57CD)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    appLocalizations!.precedent,
                    style: const TextStyle(
                        color: Color(0xff4E57CD), fontSize: 20),
                  ),
                ),
                onPressed: () {
                  AddMeeting.setProgress(context, 0.75);
                  AddMeeting.setIndex(context, 2);
                },
              ),
            ),
            Expanded(
              child: CupertinoButton(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient:  LinearGradient(
                      colors: !boxCheck?[CupertinoColors.inactiveGray,Colors.grey]: [Color(0xff4E57CD), Color(0xff2F38A5)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    appLocalizations.valide,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String? token = prefs.getString('tokenDoc');
                  await api.post(
                    EndPoints.CreateDiscussion,
                    data: {
                      "titre": titre,
                      "prenomPatient": prenomPatient,
                      "nomPatient": nomPatient,
                      "sexe": sexe.toUpperCase(),
                      "age": age,
                      "motifDeTeleExpertise": motifDeTeleExpertise,
                      "antecedentsMedicaux": antecedentsMedicaux,
                      "antecedentsChirurgicaux": antecedentsChirurgicaux,
                      "habitudes": habitude,
                      "descriptionDesHabitudes": descriptionDesHabitudes,
                      "antecedentsFamiliaux":antecedentsFamiliaux,
                      "descriptionEtatClinique": descriptionEtatClinique,
                      "commentaireFichiers": "string",
                      "genre": genre.toUpperCase(),
                      "type": type,
                      "date": date,
                      "heure": heure,
                      "fichiersAtaches": [],
                      "medecinsInvitesIds": medecinsInvitesIds,
                      "specialitesDemandees": specialitesDemandees,
                      "medcinResponsableId": prefs.getInt("IdDoc")
                    },
                    headers: {
                    "Authorization": "$token",
                  },
                  );
                   titre="";
                   motif="";
                   prenomPatient="";
                   nomPatient="";
                   sexe="";
                   age=0;
                   motifDeTeleExpertise="";
                   antecedentsMedicaux=[];
                   antecedentsChirurgicaux="";
                   habitude=[];
                   descriptionDesHabitudes="";
                   antecedentsFamiliaux=[];
                   descriptionEtatClinique="";
                   commentaireFichiers="";
                   genre="";
                   type="";
                   date="";
                   heure="";
                   duree=0;
                   status="";
                   fichiersAtaches=[];
                   medecinsInvitesIds=[];
                   specialitesDemandees=[];
                   medcinResponsableId=0;
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
