import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'addMeeting.dart';

class Creatediscussion extends StatefulWidget {
  const Creatediscussion({super.key});

  @override
  State<Creatediscussion> createState() => _CreatediscussionState();
}

class _CreatediscussionState extends State<Creatediscussion> {
  DateTime selectedTime = DateTime.now();
  DateTime tempSelectedTime = DateTime.now();
  List<String> consomation = [];

  List<String> medicalHistoryList = [];
  List<String> surgicalHistoryList = [];
  List<String> familyHistoryList = [];

  void addSexe() {
    if (!consomation.contains(AppLocalizations.of(context)!.male) && !consomation.contains(AppLocalizations.of(context)!.female)) {
      consomation.add(AppLocalizations.of(context)!.male);
      consomation.add(AppLocalizations.of(context)!.female);
    }
  }

  static int selectedConsomation = -1;
  String? selectedMedicalHistory;
  String? selectedFamilyHistory;
  String? selectedHabitude;
  bool isOtherFamilyHistory = false;

  final List<String> medicalHistoryOptions = [
    "Asthme",
    "Diabète",
    "Épilepsie",
    "Troubles du spectre de l'autisme (TSA)",
    "Troubles du sommeil"
  ];

  final List<String> familyHistoryOptions = [
    "Diabète",
    "Hypertension artérielle (tension)",
    "Cancer",
    "Maladie cardio-vasculaire",
    "aucune",
    "autre"
  ];

  final List<String> habitudes = [
    "Sport",
    "Tabac",
    "Alcool",
    "Temps d'ecran"
  ];

  void showPicker(BuildContext context, List<String> items, String? selectedItem, ValueChanged<String?> onSelected) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Cardi.isDarkMode.value ? Colors.black87 : Colors.white70,
          child: Column(
            children: [
              Container(
                color: Cardi.isDarkMode.value ? Colors.black87 : Colors.white70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text(AppLocalizations.of(context)!.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child:  Text(AppLocalizations.of(context)!.done),
                      onPressed: () {
                        onSelected(tempSelectedItem);
                        Navigator.of(context).pop();
                      },
                    ),

                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  backgroundColor: Cardi.isDarkMode.value ? Colors.black87 : Colors.white70,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    tempSelectedItem = items[index];
                  },
                  children: items.map((item) => Center(child: Text(item, style: TextStyle(color: !Cardi.isDarkMode.value ? Colors.black87 : Colors.white70)))).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  bool visiHab=false;
  bool visiFam=false;

  String? tempSelectedItem;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);
    addSexe();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appLocalizations!.nomPatient, style: const TextStyle(fontSize: 16)),
                SizedBox(
                  height: height * 0.06,
                  width: width * 0.42,
                  child: CupertinoTextField(
                    style: TextStyle(
                      color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                    ),
                    placeholder: appLocalizations.nom,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appLocalizations.prenomPatient, style: const TextStyle(fontSize: 16)),
                SizedBox(
                  height: height * 0.06,
                  width: width * 0.42,
                  child: CupertinoTextField(
                    style: TextStyle(
                      color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                    ),
                    placeholder: appLocalizations.prenom,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: height * 0.07,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                appLocalizations.sex,
                style: const TextStyle(fontSize: 16),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List<Widget>.generate(consomation.length, (int index) {
                  return ChoiceChip(
                    checkmarkColor: Colors.greenAccent,
                    backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
                    selectedColor: const Color(0xff5c00ff),
                    label: Text(
                      consomation[index],
                      style: GoogleFonts.aBeeZee(
                        color: selectedConsomation == index
                            ? Colors.white
                            : Cardi.isDarkMode.value ? CupertinoColors.inactiveGray : Colors.black,
                      ),
                    ),
                    selected: selectedConsomation == index,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedConsomation = selected ? index : -1;
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalizations.antecedentsPersonnels, style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 20))),
            const SizedBox(height: 10),
            buildDropdown('1- ${appLocalizations.antecedantMedicaux}', appLocalizations.select, medicalHistoryOptions, selectedMedicalHistory, (value) {
              setState(() {
                selectedMedicalHistory = value;
                if (value != null) {
                  medicalHistoryList.add(value);
                }
              });
            }),

            buildChipList(medicalHistoryList, (index) {
              setState(() {
                medicalHistoryList.removeAt(index);
              });
            }),
            const SizedBox(height: 10),
            buildTextField('2- ${appLocalizations.antecedantChirugi}', appLocalizations.surgicalHistoryDetails, (value) {
            },true),
            const SizedBox(height: 10),
            buildDropdown('3- ${appLocalizations.habitudes}', appLocalizations.select, habitudes, selectedHabitude, (value) {
              setState(() {
                selectedHabitude = value;
                if (value!.isNotEmpty&& !surgicalHistoryList.contains(selectedHabitude)) {
                  surgicalHistoryList.add(value);
                  visiHab=true;
                }
              });
            }),
            Visibility(
              visible: visiHab,
              child: buildTextField('', appLocalizations.moreDetailsHabits, (value) {
              },false),
            ),
            buildChipList(surgicalHistoryList, (index) {
              setState(() {
                surgicalHistoryList.removeAt(index);
                if (surgicalHistoryList.isEmpty){
                  visiHab=false;
                }
              });
            }),
            const SizedBox(height: 10),
            buildDropdown('4- ${appLocalizations.antecedantFamil}', appLocalizations.select, familyHistoryOptions, selectedFamilyHistory, (value) {
              setState(() {
                if (value == 'autre') {
                  isOtherFamilyHistory = true;
                }
                selectedFamilyHistory = value;
                if (value != null && !familyHistoryList.contains(selectedFamilyHistory)) {
                  familyHistoryList.add(value);
                  visiFam=true;
                }
              });
            }),
            Visibility(
              visible: visiFam,
              child: buildTextField('', appLocalizations.moreDetailsFamilyHistory, (value) {
              },false),
            ),
            buildChipList(familyHistoryList, (index) {
              setState(() {
                familyHistoryList.removeAt(index);
                if (familyHistoryList.isEmpty){
                  visiFam=false;
                }
              });
            }),
          ],
        ),

        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalizations.descriptionEtatClinique, style: const TextStyle(fontSize: 16)),
            SizedBox(
              width: width,
              child: CupertinoTextField(
                style: TextStyle(
                  color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                ),
                minLines: 1,
                maxLines: 4,
                placeholder: appLocalizations.description,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalizations.titleDiscussion, style: const TextStyle(fontSize: 16)),
            SizedBox(
              width: width,
              child: CupertinoTextField(
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
        SizedBox(height: height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appLocalizations.motifDiscussion, style: const TextStyle(fontSize: 16)),
            SizedBox(
              width: width,
              child: CupertinoTextField(
                style: TextStyle(
                  color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                ),
                minLines: 1,
                maxLines: 4,
                placeholder: appLocalizations.poserQuestions,
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

        CupertinoButton(
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
            AddMeeting.setIndex(context,1);
            // switch(selectedConditionIndex){
            //   case 0:{
            //     if(controller.text.isEmpty){
            //       Fluttertoast.showToast(msg: appLocalizations.enter_type_of_medication);
            //     }else{
            //       typeMedicaments=controller.text;
            //       DocMedical.setProgress(context, 0.25);
            //       DocMedical.setIndex(context, 1);
            //     }
            //     break;
            //   }
            //   case 1:{
            //     typeMedicaments=controller.text;
            //     DocMedical.setProgress(context, 0.25);
            //     DocMedical.setIndex(context, 1);
            //   }
            // }
          },
        ),
      ],
    );
  }

  Widget buildDropdown(String label, String hint, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16))),
        const SizedBox(height: 5),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.systemGrey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedItem ?? hint,
                  style: TextStyle(
                    color: selectedItem == null
                        ? CupertinoColors.inactiveGray
                        : Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                  ),
                ),
                const Icon(CupertinoIcons.chevron_down, color: CupertinoColors.inactiveGray),
              ],
            ),
          ),
          onPressed: () {
            tempSelectedItem = selectedItem; // Set the initial tempSelectedItem
            showPicker(context, items, selectedItem, onChanged);
          },
        ),
      ],
    );
  }

  Widget buildTextField(String label, String placeholder, ValueChanged<String?> onChanged,bool visibility) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: visibility,
            child: Text(label, style: GoogleFonts.inter(textStyle: const TextStyle(fontSize: 16)))),
        const SizedBox(height: 5),
        CupertinoTextField(
          maxLines: 2,
          placeholder: placeholder,
          style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: CupertinoColors.systemGrey,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          onSubmitted: onChanged,
        ),
      ],
    );
  }

  Widget buildChipList(List<String> items, ValueChanged<int> onDeleted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: List<Widget>.generate(items.length, (int index) {
            return Chip(
              backgroundColor: const Color(0xff2F38A5),
              label: Text(items[index]),
              onDeleted: () {
                onDeleted(index);
              },
            );
          }),
        ),
      ],
    );
  }
}
