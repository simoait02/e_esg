import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'data.dart';
class Docmedical01 extends StatefulWidget {
  const Docmedical01({super.key});

  @override
  State<Docmedical01> createState() => _Docmedical01State();
}

class _Docmedical01State extends State<Docmedical01> {
  bool isSelectedImage = false;
  static List<String> conditions = [
    "Asthme",
    "Diabète",
    "Épilepsie",
    "Troubles du spectre de l'autisme (TSA)",
    "Troubles du sommeil"
  ];
  static List<bool> selectedConditions = [false, false, false, false, false];
  static List<String> conditions1 = ["Oui", "Non"];
  static int selectedConditionIndex = -1;

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;
  bool error = false;

  @override
  void initState() {
    super.initState();
    controller.text=typeMedicaments;
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    double height = MediaQuery.of(context).size.height;

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
          appLocalizations.chronic_diseases,
          maxLines: 2,
          style: GoogleFonts.inter(
            color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: height * 0.01),
        AutoSizeText(
          appLocalizations.select_none_or_multiple,
          maxLines: 1,
          style: GoogleFonts.inter(
            color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w200,
          ),
        ),
        SizedBox(height: height * 0.02),
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
                  if (selected) {
                    chronique.add(conditions[index]);
                  } else {
                    chronique.remove(conditions[index]);
                  }
                  print(chronique); // For debugging purposes
                });
              },
            );
          }),
        ),
        SizedBox(height: height * 0.02),
        AutoSizeText(
          appLocalizations.use_medication,
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
                      controller.clear();
                    }
                  });
                },
              );
            }),
          ),
        ),
        SizedBox(height: height * 0.02),
        Visibility(
          visible: selectedConditionIndex == 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                appLocalizations.type_of_medication,
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
                height: 45,
                child: CupertinoTextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: hasFocus
                          ? const Color(0xFF2E37A4)
                          : error
                          ? Colors.red
                          : CardiJeune.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  placeholder: appLocalizations.enter_type_of_medication,
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
                      focusNode.unfocus();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        CupertinoButton(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient:selectedConditionIndex==-1?const LinearGradient(
                colors: [Colors.grey, Colors.grey],
              ): const LinearGradient(
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
            switch(selectedConditionIndex){
              case 0:{
                if(controller.text.isEmpty){
                  Fluttertoast.showToast(msg: appLocalizations.enter_type_of_medication);
                }else{
                  typeMedicaments=controller.text;
                  DocMedical.setProgress(context, 0.25);
                  DocMedical.setIndex(context, 1);
                }
                break;
              }
              case 1:{
                typeMedicaments=controller.text;
                DocMedical.setProgress(context, 0.25);
                DocMedical.setIndex(context, 1);
              }
            }
          },
        ),
      ],
    );
  }
}
