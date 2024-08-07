import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class Invitationinfos extends StatefulWidget {
  final String titre;
  final String prenomPatient;
  final String nomPatient;
  final String sexe;
  final int age;
  final String motifDeTeleExpertise;
  final List antecedentsMedicaux;
  final String antecedentsChirurgicaux;
  final List habitude;
  final String descriptionDesHabitudes;
  final List antecedentsFamiliaux;
  final String descriptionEtatClinique;
  final String commentaireFichiers;
  final String genre;
  final String type;
  final String date;
  final String heure;
  final String status;
  final List fichiersAtaches;
  final List specialitesDemandees;

  const Invitationinfos({
    Key? key,
    required this.titre,
    required this.prenomPatient,
    required this.nomPatient,
    required this.sexe,
    required this.age,
    required this.motifDeTeleExpertise,
    required this.antecedentsMedicaux,
    required this.antecedentsChirurgicaux,
    required this.habitude,
    required this.descriptionDesHabitudes,
    required this.antecedentsFamiliaux,
    required this.descriptionEtatClinique,
    required this.commentaireFichiers,
    required this.genre,
    required this.type,
    required this.date,
    required this.heure,
    required this.status,
    required this.fichiersAtaches,
    required this.specialitesDemandees,
  }) : super(key: key);

  @override
  State<Invitationinfos> createState() => _InvitationinfosState();
}

class _InvitationinfosState extends State<Invitationinfos> {
  Widget buildItem(String key,String value){
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              key,
              style: GoogleFonts.aBeeZee(
                  fontSize: 16
              ),
            )
        ),
        SizedBox(width: 10,),
        Expanded(
            flex: 2,
            child: Text(
              value,
              style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  color: Cardi.isDarkMode.value
                      ? Colors.white54
                      : Colors.black54
              ),
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text("Télé-Expertise",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: const Color(0xff4E57CD)
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Cardi.isDarkMode.value?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    buildItem(appLocalizations!.titleDiscussion, widget.titre),
                    const Divider(),
                    buildItem(appLocalizations.motifDiscussion, widget.motifDeTeleExpertise),
                    const Divider(),
                    buildItem(appLocalizations.prenomPatient, widget.prenomPatient),
                    const Divider(),
                    buildItem(appLocalizations.nomPatient, widget.nomPatient),
                    const Divider(),
                    buildItem(appLocalizations.sex, widget.sexe),
                    const Divider(),
                    buildItem(appLocalizations.agePatient, widget.age.toString()),
                    const Divider(),
                    buildItem(appLocalizations.antecedentsMedicaux, widget.antecedentsMedicaux.toString()),
                    const Divider(),
                    buildItem(appLocalizations.antecedentsChirurgicaux, widget.antecedentsChirurgicaux),
                    const Divider(),
                    buildItem(appLocalizations.habitudes, widget.habitude.toString()),
                    const Divider(),
                    buildItem(appLocalizations.descHabitude, widget.antecedentsMedicaux.toString()),
                    const Divider(),
                    buildItem(appLocalizations.antecedentsFamiliaux, widget.antecedentsFamiliaux.toString()),
                    const Divider(),
                    buildItem(appLocalizations.descriptionEtatClinique, widget.descriptionEtatClinique),
                    const Divider(),
                    buildItem(appLocalizations.commentaireFichiers, widget.antecedentsMedicaux.toString()),
                    const Divider(),
                    buildItem(appLocalizations.gen, widget.genre),//999
                    const Divider(),
                    buildItem(appLocalizations.typeDiscussion, widget.type),
                    const Divider(),
                    buildItem(appLocalizations.date, DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.date))),
                    const Divider(),
                    buildItem(appLocalizations.time, widget.heure),
                    const Divider(),
                    buildItem(appLocalizations.speciality, widget.specialitesDemandees.toString()),

                  ],
                ),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
