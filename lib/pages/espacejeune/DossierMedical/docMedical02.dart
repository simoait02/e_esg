import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/data.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Docmedical02 extends StatefulWidget {
  const Docmedical02({super.key});

  @override
  State<Docmedical02> createState() => _Docmedical02State();
}

 final TextEditingController operationTypeController = TextEditingController();
 final TextEditingController operationYearController = TextEditingController();
 final TextEditingController nbCigarController = TextEditingController();
 final FocusNode nbCigarFocusNode = FocusNode();
 final FocusNode operationTypeFocusNode = FocusNode();
 final FocusNode operationYearFocusNode = FocusNode();

class _Docmedical02State extends State<Docmedical02> {
  List<String> conditions1 = ["Oui", "Non"];
  static int selectedConditionIndex = -1;

  bool hasOperationTypeFocus = false;
  bool hasOperationYearFocus = false;
  bool hasnbCigarFocus = false;

  bool error = false;

  @override
  void initState() {
    super.initState();
    nbCigarFocusNode.addListener(() {
      setState(() {
        hasnbCigarFocus = nbCigarFocusNode.hasFocus;
      });
    });
    operationTypeFocusNode.addListener(() {
      setState(() {
        hasOperationTypeFocus = operationTypeFocusNode.hasFocus;
      });
    });
    operationYearFocusNode.addListener(() {
      setState(() {
        hasOperationYearFocus = operationYearFocusNode.hasFocus;
      });
    });
  }

  static List<String> temps = [
    "1-2h",
    "3-5h",
    "+5h"
  ];
  static int selectedTemp = -1;
  static List<String> consomation = [
    "Quotidien",
    "Occasionnel"
  ];
  static int selectedConsomation = -1;
  static List<String> conditions = [
    "Sport",
    "Tabac",
    "Alcool",
    "Temps d'ecran"
  ];
  static List<bool> selectedConditions = [false, false, false, false];

  static bool c1 = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeText(
          appLocalizations!.medical_history,
          maxLines: 2,
          style: GoogleFonts.inter(
            color: const Color(0xff2e37a4),
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.01),
        AutoSizeText(
          appLocalizations.enter_information,
          maxLines: 1,
          style: GoogleFonts.inter(
            color: const Color(0xff5c00ff),
            fontSize: 17,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: height * 0.05),
        AutoSizeText(
          appLocalizations.suffer_surgical_diseases,
          maxLines: 2,
          style: GoogleFonts.inter(
            color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: height * 0.01),
        Align(
          alignment: Alignment.center,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List<Widget>.generate(conditions1.length, (int index) {
              return ChoiceChip(
                checkmarkColor: Colors.greenAccent,
                backgroundColor: CardiJeune.isDarkMode.value
                    ? const Color(0xff141218)
                    : Colors.white,
                selectedColor: const Color(0xff5c00ff),
                label: Text(
                  conditions1[index],
                  style: GoogleFonts.aBeeZee(
                    color: selectedConditionIndex == index
                        ? Colors.white
                        :  CardiJeune.isDarkMode.value?Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5),
                  ),
                ),
                selected: selectedConditionIndex == index,
                onSelected: (bool selected) {
                  setState(() {
                    selectedConditionIndex = selected ? index : -1;
                    if (!selected) {
                      chirurgicaux=false;
                      c1=false;
                      operationTypeController.clear();
                      operationYearController.clear();
                      return;
                    }
                    chirurgicaux=selectedConditionIndex==0?true:false;
                    c1=true;
                  });
                },
              );
            }),
          ),
        ),
        Visibility(
          visible: selectedConditionIndex == 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                appLocalizations.operation_type,
                maxLines: 2,
                style: GoogleFonts.inter(
                  color: CardiJeune.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: 50,
                child: CupertinoTextField(
                  controller: operationTypeController,
                  focusNode: operationTypeFocusNode,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: hasOperationTypeFocus
                          ? const Color(0xFF2E37A4)
                          : error
                          ? Colors.red
                          : CardiJeune.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  placeholder: appLocalizations.enter_operation_type,
                  placeholderStyle: TextStyle(
                    color: CardiJeune.isDarkMode.value
                        ? Colors.white.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5),
                  ),
                  style: TextStyle(
                    color: CardiJeune.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  onTapOutside: (event) {
                    setState(() {
                      operationTypeFocusNode.unfocus();
                    });
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              AutoSizeText(
                appLocalizations.operation_year,
                maxLines: 2,
                style: GoogleFonts.inter(
                  color: CardiJeune.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: 50,
                child: CupertinoTextField(
                  controller: operationYearController,
                  focusNode: operationYearFocusNode,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: hasOperationYearFocus
                          ? const Color(0xFF2E37A4)
                          : error
                          ? Colors.red
                          : CardiJeune.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  placeholder: appLocalizations.enter_operation_year,
                  placeholderStyle: TextStyle(
                    color: CardiJeune.isDarkMode.value
                        ? Colors.white.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5),
                  ),
                  style: TextStyle(
                    color: CardiJeune.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  onTapOutside: (event) {
                    setState(() {
                      operationYearFocusNode.unfocus();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        AutoSizeText(
          appLocalizations.habits_question,
          maxLines: 2,
          style: GoogleFonts.inter(
            color: CardiJeune.isDarkMode.value
                ? Colors.white
                : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        AutoSizeText(
          appLocalizations.select_none_or_multiple,
          maxLines: 1,
          style: GoogleFonts.inter(
            color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: height * 0.01),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List<Widget>.generate(conditions.length, (int index) {
            return ChoiceChip(
              checkmarkColor: Colors.greenAccent,
              backgroundColor: CardiJeune.isDarkMode.value ? const Color(0xff141218) : Colors.white,
              selectedColor: const Color(0xff5c00ff),
              label: Text(
                conditions[index],
                style: GoogleFonts.aBeeZee(
                  color: selectedConditions[index] ? Colors.white : CardiJeune.isDarkMode.value?Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5),
                ),
              ),
              selected: selectedConditions[index],
              onSelected: (bool selected) {
                setState(() {
                  selectedConditions[index] = selected;
                  if (selected) {
                    habitudes.add(conditions[index]);
                  } else {
                    habitudes.remove(conditions[index]);
                  }
                  print(habitudes); // For debugging purposes
                });
              },
            );
          }),
        ),
        Visibility(
            visible: selectedConditions[1],
            child: Column(
              children: [
                SizedBox(height: height*0.02,),
                AutoSizeText(
                  appLocalizations.cigarettes_per_day,
                  maxLines: 2,
                  style: GoogleFonts.inter(
                    color: CardiJeune.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 50,
                  child: CupertinoTextField(
                    controller: nbCigarController,
                    focusNode: nbCigarFocusNode,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: hasnbCigarFocus
                            ? const Color(0xFF2E37A4)
                            : error
                            ? Colors.red
                            : CardiJeune.isDarkMode.value
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    placeholder: appLocalizations.enter_cigarettes_per_day,
                    placeholderStyle: TextStyle(
                      color: CardiJeune.isDarkMode.value
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.5),
                    ),
                    style: TextStyle(
                      color: CardiJeune.isDarkMode.value
                          ? Colors.white
                          : Colors.black,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    onTapOutside: (event) {
                      setState(() {
                      });
                    },
                  ),
                ),
              ],
            ),
        ),
        Visibility(
          visible: selectedConditions[2],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.02,),
              AutoSizeText(
                appLocalizations.alcohol_consumption,
                maxLines: 2,
                style: GoogleFonts.inter(
                  color: CardiJeune.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List<Widget>.generate(consomation.length, (int index) {
                    return ChoiceChip(
                      checkmarkColor: Colors.greenAccent,
                      backgroundColor: CardiJeune.isDarkMode.value
                          ? const Color(0xff141218)
                          : Colors.white,
                      selectedColor: const Color(0xff5c00ff),
                      label: Text(
                        consomation[index],
                        style: GoogleFonts.aBeeZee(
                          color: selectedConsomation == index
                              ? Colors.white
                              :  CardiJeune.isDarkMode.value?Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5),
                        ),
                      ),
                      selected: selectedConsomation == index,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedConsomation = selected ? index : -1;
                          consomationAlcohol=consomation[index];
                          print(consomationAlcohol);
                        });
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: selectedConditions[3],
          child: Column(
            children: [
              SizedBox(height: height*0.02,),
              AutoSizeText(
                appLocalizations.screen_time,
                maxLines: 2,
                style: GoogleFonts.inter(
                  color: CardiJeune.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List<Widget>.generate(temps.length, (int index) {
                  return ChoiceChip(
                    checkmarkColor: Colors.greenAccent,
                    backgroundColor: CardiJeune.isDarkMode.value
                        ? const Color(0xff141218)
                        : Colors.white,
                    selectedColor: const Color(0xff5c00ff),
                    label: Text(
                      temps[index],
                      style: GoogleFonts.aBeeZee(
                        color: selectedTemp == index
                            ? Colors.white
                            :  CardiJeune.isDarkMode.value?Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5),
                      ),
                    ),
                    selected: selectedTemp == index,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedTemp = selected ? index : -1;
                        tempsEcran=temps[index];
                        print(tempsEcran);
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
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
                    appLocalizations.precedent,
                    style: const TextStyle(
                        color: Color(0xff4E57CD), fontSize: 20),
                  ),
                ),
                onPressed: () {
                  DocMedical.setProgress(context, 0.1);
                  DocMedical.setIndex(context, 0);
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
                    appLocalizations.suivant,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onPressed: () {
                  if(!c1){
                    Fluttertoast.showToast(msg: "Souffrez-vous de maladies chirurgicaux");
                    return;
                  }
                  if((operationTypeController.text.isEmpty||operationYearController.text.isEmpty)&& selectedConditionIndex==0){
                    Fluttertoast.showToast(msg: "entrez le type et l'annee de l'operation");
                    return;
                  }
                  if(selectedConditions[1]&& nbCigarController.text.isEmpty){
                    Fluttertoast.showToast(msg: "entrez le nombre de cigarettes");
                    return;
                  }
                  if(selectedConsomation==-1&&selectedConditions[2]){
                    Fluttertoast.showToast(msg: "choisir une consomation");
                    return;
                  }
                  if(selectedTemp==-1&&selectedConditions[3]){
                    Fluttertoast.showToast(msg: "choisir une estimation de temps");
                    return;
                  }
                  if(selectedConditions[1]){
                    try{
                      cigarettesParJour=int.parse(nbCigarController.text);

                    }catch(e){
                      Fluttertoast.showToast(msg: "entrez le nombre de cigarettes correct");
                      return;
                    }
                  }
                  if(selectedConditionIndex==0){
                    try{
                      operationsChirurgicales={
                        "typeOperation":operationTypeController.text,
                        "anneeOperation":int.parse(operationYearController.text)
                      };
                    }catch(e){
                      Fluttertoast.showToast(msg: "entrez l'annee de l'operation correct");
                      return;
                    }
                  }


                  print(operationsChirurgicales);
                  DocMedical.setProgress(context, 0.5);
                  DocMedical.setIndex(context, 2);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
