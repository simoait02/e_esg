import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Docmedical02 extends StatefulWidget {
  const Docmedical02({super.key});

  @override
  State<Docmedical02> createState() => _Docmedical02State();
}

class _Docmedical02State extends State<Docmedical02> {
  List<String> conditions1 = ["Oui", "Non"];
  int selectedConditionIndex = -1;

  // Controllers and focus nodes for the text fields
  TextEditingController operationTypeController = TextEditingController();
  TextEditingController operationYearController = TextEditingController();
  TextEditingController nbCigarController = TextEditingController();
  FocusNode nbCigarFocusNode = FocusNode();
  FocusNode operationTypeFocusNode = FocusNode();
  FocusNode operationYearFocusNode = FocusNode();
  bool hasOperationTypeFocus = false;
  bool hasOperationYearFocus = false;
  bool hasnbCigarFocus = false;

  bool error = false; // To show error state if needed

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
  @override
  void dispose() {
    operationTypeController.dispose();
    operationYearController.dispose();
    operationTypeFocusNode.dispose();
    operationYearFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeText(
          "Antécédents Personnels Médicaux",
          maxLines: 2,
          style: GoogleFonts.inter(
            color: const Color(0xff2e37a4),
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: height * 0.01),
        AutoSizeText(
          "Veuillez saisir les informations suivantes",
          maxLines: 1,
          style: GoogleFonts.inter(
            color: const Color(0xff5c00ff),
            fontSize: 17,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: height * 0.05),
        AutoSizeText(
          "Souffrez-vous de maladies chirurgicaux?",
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
                        : Colors.black,
                  ),
                ),
                selected: selectedConditionIndex == index,
                onSelected: (bool selected) {
                  setState(() {
                    selectedConditionIndex = selected ? index : -1;
                    if (!selected) {
                      operationTypeController.clear();
                      operationYearController.clear();
                    }
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
                "Type d'opération",
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
                  placeholder: "Entrez le type de médicaments",
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
                "Année de l'opération",
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
                  placeholder: "Entrez l'année de l'opération",
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
          "Avez-vous certaines de ces habitudes?",
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
          "Vous pouvez sélectionner aucune ou plusieurs.",
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
                  color: selectedConditions[index] ? Colors.white : Colors.black,
                ),
              ),
              selected: selectedConditions[index],
              onSelected: (bool selected) {
                setState(() {
                  selectedConditions[index] = selected;
                  // if (selected) {
                  //   chronique.add(conditions[index]);
                  // } else {
                  //   chronique.remove(conditions[index]);
                  // }
                  // print(chronique); // For debugging purposes
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
                  "Combien de cigarettes fumez-vous par jour?",
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
                  margin: EdgeInsets.only(top: 10),
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
                    placeholder: "Entrez le nombre de cigarettes fumées par jeur",
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
                "Consomation d'alcool?",
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
                              : Colors.black,
                        ),
                      ),
                      selected: selectedConsomation == index,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedConsomation = selected ? index : -1;
                          if (!selected) {
                            operationTypeController.clear();
                            operationYearController.clear();
                          }
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
                "Combien de temps passez-vous devant un écran par jour?",
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
                            : Colors.black,
                      ),
                    ),
                    selected: selectedTemp == index,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedTemp = selected ? index : -1;
                        if (!selected) {
                          operationTypeController.clear();
                          operationYearController.clear();
                        }
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xff4E57CD)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Précédent",
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
                    "Suivant",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                onPressed: () {
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
