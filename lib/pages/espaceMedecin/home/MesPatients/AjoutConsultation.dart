import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/errors/Exceptions.dart';
import '../../LoginSignUp/Cardi.dart';
class Ajoutconsultation extends StatefulWidget {
  const Ajoutconsultation({super.key});

  @override
  State<Ajoutconsultation> createState() => _AjoutconsultationState();
}

class _AjoutconsultationState extends State<Ajoutconsultation> {
  bool datenull = false;
  DateTime? selectedDateTime;
  DateTime? tempSelectedDateTime;
  String label="date de la consultation";
  String label1 = "Heure de la consultation";
  DateTime selectedTime = DateTime.now();
  DateTime tempSelectedTime = DateTime.now();
  String errorText="";
  final TextEditingController motifConsultationController = TextEditingController();
  final TextEditingController TypeExamenController = TextEditingController();
  final TextEditingController SpecificationExamenController = TextEditingController();
  final TextEditingController AutreSpecificationController = TextEditingController();
  final TextEditingController HistoriqueClinicController = TextEditingController();
  final TextEditingController ExamenClinicController = TextEditingController();
  final TextEditingController DiagnosticController = TextEditingController();
  final TextEditingController OrdonnanceController = TextEditingController();
  void updateDate(DateTime newDate) {
    setState(() {
      selectedDateTime = newDate;
      label = intl.DateFormat('yyyy-MM-dd').format(selectedDateTime!);
    });
  }
  @override
  void dispose(){
    super.dispose();
    motifConsultationController.dispose();
    DiagnosticController.dispose();
    OrdonnanceController.dispose();
    TypeExamenController.dispose();
    SpecificationExamenController.dispose();
    AutreSpecificationController.dispose();
    HistoriqueClinicController.dispose();
    ExamenClinicController.dispose();

  }
  void updateTime(DateTime newTime) {
    setState(() {
      selectedTime = newTime;
      label1 = DateFormat.Hm().format(selectedTime);
    });
  }
  @override
  void initState() {
    super.initState();
  }
  bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context)!;

    double sectionPadding = screenWidth * 0.03;
    double titleFontSize = screenWidth * 0.06;

    dynamic patient = ModalRoute.of(context)!.settings.arguments as dynamic;

    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(sectionPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Center(
                      child: AutoSizeText("Ajouter une consultation",
                        style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: titleFontSize,
                      ),),
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: height * 0.03,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: AutoSizeText(
                        appLocalizations.date,
                        style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: titleFontSize+15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tempSelectedDateTime = selectedDateTime;
                        });
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              width: screenWidth,
                              height: height * 0.35,
                              color: Cardi.isDarkMode.value ? CupertinoColors.black : CupertinoColors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CupertinoButton(
                                        child: Text(
                                          appLocalizations.cancel,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: Text(
                                          appLocalizations.done,
                                          style: TextStyle(color: Color(0xff2E37A5)),
                                        ),
                                        onPressed: () {
                                          if (tempSelectedDateTime != null) {
                                            updateDate(tempSelectedDateTime!);
                                          }
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: CupertinoTheme(
                                      data: CupertinoThemeData(
                                        textTheme: CupertinoTextThemeData(
                                          dateTimePickerTextStyle: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: CupertinoDatePicker(
                                        initialDateTime: selectedDateTime ?? DateTime.now(),
                                        onDateTimeChanged: (DateTime newDate) {
                                          setState(() {
                                            tempSelectedDateTime = newDate;
                                          });
                                        },
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: height * 0.055,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(label),
                            Icon(
                              CupertinoIcons.calendar,
                              color: Cardi.isDarkMode.value
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: height * 0.03,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: AutoSizeText(
                        appLocalizations.time,
                        style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: titleFontSize+15,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tempSelectedTime = selectedTime;
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              width: screenWidth,
                              height: height * 0.35,
                              color: Cardi.isDarkMode.value
                                  ? CupertinoColors.black
                                  : CupertinoColors.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CupertinoButton(
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoButton(
                                        child: const Text(
                                          "Done",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () {
                                          updateTime(tempSelectedTime);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: CupertinoTheme(
                                      data: CupertinoThemeData(
                                        textTheme: CupertinoTextThemeData(
                                          dateTimePickerTextStyle: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                              color: Cardi.isDarkMode.value
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: CupertinoDatePicker(
                                        initialDateTime: selectedTime,
                                        onDateTimeChanged: (DateTime newTime) {
                                          tempSelectedTime = newTime;
                                        },
                                        mode: CupertinoDatePickerMode.time,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: height * 0.055,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Cardi.isDarkMode.value
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(label1),
                            Icon(
                              CupertinoIcons.time,
                              color: Cardi.isDarkMode.value
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Motif de la consultation",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: motifConsultationController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Type d'examen",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: TypeExamenController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Specifications d'examen",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: SpecificationExamenController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Autres specifications",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: AutreSpecificationController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            placeholder: "Si vous avez d'autres specifications merci de le fournir",
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Historique clinique",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: HistoriqueClinicController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Examen clinique",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: ExamenClinicController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
                      ],
                    )
                    ,SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Diagnostique",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: DiagnosticController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
                      ],
                    ),SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: AutoSizeText(
                            "Ordonnance",
                            style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: titleFontSize+15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth,
                          child: CupertinoTextField(
                            controller: OrdonnanceController,
                            style: TextStyle(
                              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                            ),
                            minLines: 1,
                            maxLines: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                        )
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
                                "Annuler",
                                style: const TextStyle(
                                    color: Color(0xff4E57CD), fontSize: 20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                          child: CupertinoButton(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                "Ajouter",
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                if(label=='date de la consultation') errorText="priere de specifier la date de consultation";
                                else if(label1=='Heure de la consultation') errorText="Priere de specifier l'heure de consultation";
                                else if(motifConsultationController.text.isEmpty) errorText="priere de specifier le motif de consultation";
                                else if(TypeExamenController.text.isEmpty) errorText="priere de specifier le type d'examen";
                                else if(SpecificationExamenController.text.isEmpty) errorText="priere de specifier les specifications d'examen";
                                else if(HistoriqueClinicController.text.isEmpty) errorText="priere de specifier l'historique clinique";
                                else if(ExamenClinicController.text.isEmpty) errorText="priere de specifier l'examen clinique";
                                else if(DiagnosticController.text.isEmpty) {errorText="priere de specifier le diagnostique";
                                print("${DiagnosticController.text}");}
                                else if(OrdonnanceController.text.isEmpty) errorText="priere de specifier l'ordonnance";
                              });
                              if(errorText!="") {Fluttertoast.showToast(
                                msg: errorText,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              setState(() {
                                errorText="";
                              });}
                              else{
                                try{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  String? token = prefs.getString('tokenDoc');
                                  int? id = prefs.getInt("IdDoc");
                                  print(patient["dossierMedial"]["antecedentsPersonnels"][0]["type"]);
                                  await api.post(
                                    "/$id/${EndPoints.PostConsultation}",
                                    data: {
                                      "date": "${label}T$label1",
                                      "motif": motifConsultationController.text,
                                      "antecedentPersonnel": {
                                        "type": patient["dossierMedial"]["antecedentsPersonnels"][0]["type"],
                                        "specification": patient["dossierMedial"]["antecedentsPersonnels"][0]["specification"],
                                        "specificationAutre": patient["dossierMedial"]["antecedentsPersonnels"][0]["specificationAutre"],
                                        "nombreAnnee":patient["dossierMedial"]["antecedentsPersonnels"][0]["nombreAnnee"]
                                      },
                                      "antecedentFamilial": {
                                        "typeAntFam": patient["dossierMedial"]["antecedentsFamiliaux"][0]["typeAntFam"],
                                        "autre": patient["dossierMedial"]["antecedentsFamiliaux"][0]["autre"]
                                      },
                                      "examenMedical": {
                                        "typeExamen":TypeExamenController.text,
                                        "specificationExamen": SpecificationExamenController.text,
                                        "autreSpecification": AutreSpecificationController.text
                                      },
                                      "historiqueClinique": HistoriqueClinicController.text,
                                      "examenClinique": ExamenClinicController.text,
                                      "Diagnostic": DiagnosticController.text,
                                      "Ordonnance": OrdonnanceController.text,
                                      "jeuneId":patient["id"],
                                      "medecinId": id,
                                      "dossierMedicalId": patient["dossierMedial"]['id'],
                                      "diagnostic":DiagnosticController.text,
                                      "ordonnance":OrdonnanceController.text,
                                    },
                                    headers: {
                                      "Authorization": token,
                                    }
                                  );
                                  Navigator.pop(context);
                                } on ServerException catch (e) {
                                  print("dfffffffffffffffffffffffffffffffffffffffffffffffffffff");
                                  Fluttertoast.showToast(msg: e.errormodel.errorMsg,backgroundColor: Colors.red);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

    