import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_esg/Data/allergiAlimentaire_list.dart';
import 'package:e_esg/Data/allergieMedicam_list.dart';
import 'package:e_esg/Data/allergieEnvi_list.dart';

class Docmedical03 extends StatefulWidget {
  const Docmedical03({super.key});

  @override
  State<Docmedical03> createState() => _Docmedical03State();
}

class _Docmedical03State extends State<Docmedical03> {
  TextEditingController controller = TextEditingController();
  FocusNode autreFocusNode = FocusNode();
  bool error = false;
  bool autreFocus = false;

  static List<String> conditions = [
    "Diabete",
    "Hypertension artérielle (tension)",
    "Cancer",
    "Maladie cardio-vasculaire",
    "aucune",
    "autre"
  ];
  static List<bool> selectedConditions = [false, false, false, false, false,false];

  @override
  void initState() {
    super.initState();
    autreFocusNode.addListener(() {
      setState(() {
        autreFocus = autreFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    autreFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          appLocalizations.family_member_diseases,
          maxLines: 3,
          style: GoogleFonts.inter(
            color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        AutoSizeText(
          appLocalizations.select_multiple_or_none,
          style: GoogleFonts.inter(
            color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
            fontSize: 14,
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
              backgroundColor: CardiJeune.isDarkMode.value
                  ? const Color(0xff141218)
                  : Colors.white,
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
                });
              },
            );
          }),
        ),
        Visibility(
          visible: selectedConditions[5],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              AutoSizeText(
                appLocalizations.other,
                maxLines: 2,
                style: GoogleFonts.inter(
                  color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                child: CupertinoTextField(
                  controller: controller,
                  focusNode: autreFocusNode,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: autreFocus
                          ? const Color(0xFF2E37A4)
                          : error
                          ? Colors.red
                          : CardiJeune.isDarkMode.value
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  placeholder: appLocalizations.enter_disease,
                  placeholderStyle: TextStyle(
                    color: CardiJeune.isDarkMode.value
                        ? Colors.white.withOpacity(0.5)
                        : Colors.black.withOpacity(0.5),
                  ),
                  style: TextStyle(
                    color: CardiJeune.isDarkMode.value ? Colors.white : Colors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  onTapOutside: (event) {
                    setState(() {
                      autreFocusNode.unfocus();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
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
                    appLocalizations.precedent,
                    style: const TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                  ),
                ),
                onPressed: () {
                  DocMedical.setProgress(context, 0.25);
                  DocMedical.setIndex(context, 1);
                },
              ),
            ),
            Expanded(
              child: CupertinoButton(
                child: Container(
                  padding: EdgeInsets.all(10),
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
                  DocMedical.setProgress(context, 0.75);
                  DocMedical.setIndex(context, 3);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
