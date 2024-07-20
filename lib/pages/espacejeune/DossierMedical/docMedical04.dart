import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_esg/Data/historyMedica_list.dart';
import 'package:e_esg/Data/historyDose_list.dart';
import 'package:e_esg/Data/historyInstruction_list.dart';

class Docmedical04 extends StatefulWidget {
  const Docmedical04({super.key});

  @override
  State<Docmedical04> createState() => _Docmedical04State();
}

class _Docmedical04State extends State<Docmedical04> {
  TextEditingController searchAlliController = TextEditingController();
  TextEditingController searchMedicaController = TextEditingController();
  TextEditingController searchEnviController = TextEditingController();

  List<String> suggestionsAlli = [];
  List<String> selectedItemsAlli = [];

  List<String> suggestionsMedica = [];
  List<String> selectedItemsMedica = [];

  List<String> suggestionsEnvi = [];
  List<String> selectedItemsEnvi = [];

  @override
  void initState() {
    super.initState();
    searchAlliController.addListener(() {
      filterSearchResultsAlli(searchAlliController.text);
    });
    searchMedicaController.addListener(() {
      filterSearchResultsMedica(searchMedicaController.text);
    });
    searchEnviController.addListener(() {
      filterSearchResultsEnvi(searchEnviController.text);
    });
  }

  void filterSearchResultsEnvi(String query) {
    List<String> dummySearchList = historyDoses;
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        suggestionsEnvi.clear();
        suggestionsEnvi.addAll(dummyListData);
      });
    } else {
      setState(() {
        suggestionsEnvi.clear();
      });
    }
  }

  void filterSearchResultsMedica(String query) {
    List<String> dummySearchList = historiqueDoses;
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        suggestionsMedica.clear();
        suggestionsMedica.addAll(dummyListData);
      });
    } else {
      setState(() {
        suggestionsMedica.clear();
      });
    }
  }

  void filterSearchResultsAlli(String query) {
    List<String> dummySearchList = historiqueMedicaments;
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        suggestionsAlli.clear();
        suggestionsAlli.addAll(dummyListData);
      });
    } else {
      setState(() {
        suggestionsAlli.clear();
      });
    }
  }

  void addItemEnvi(String item) {
    setState(() {
      if (!selectedItemsEnvi.contains(item)) {
        selectedItemsEnvi.add(item);
      }
      searchEnviController.clear();
      suggestionsEnvi.clear();
    });
  }

  void addItemMedica(String item) {
    setState(() {
      if (!selectedItemsMedica.contains(item)) {
        selectedItemsMedica.add(item);
      }
      searchMedicaController.clear();
      suggestionsMedica.clear();
    });
  }

  void addItemAlli(String item) {
    setState(() {
      if (!selectedItemsAlli.contains(item)) {
        selectedItemsAlli.add(item);
      }
      searchAlliController.clear();
      suggestionsAlli.clear();
    });
  }

  void removeItemEnvi(String item) {
    setState(() {
      selectedItemsEnvi.remove(item);
    });
  }

  void removeItemMedica(String item) {
    setState(() {
      selectedItemsMedica.remove(item);
    });
  }

  void removeItemAlli(String item) {
    setState(() {
      selectedItemsAlli.remove(item);
    });
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 20,
          color: Color(0xff2e37a4),
        ),
      ),
    );
  }
  String _priseEnCharge = 'médicale';
  String _correspondances = 'référence';
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                appLocalizations!.medicalPrescription,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.historyMedic),
                SizedBox(height: height * 0.01),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.055,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: searchAlliController,
                          padding: EdgeInsets.zero,
                          style: GoogleFonts.aBeeZee(
                            color: isDarkMode
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          placeholderStyle: GoogleFonts.aBeeZee(
                            color: isDarkMode
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          placeholder: appLocalizations.historyMedic,
                          onSubmitted: (value) => addItemAlli(value),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          CupertinoIcons.arrow_up_circle,
                          color: isDarkMode
                              ? CupertinoColors.white.withOpacity(0.5)
                              : CupertinoColors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                if (suggestionsAlli.isNotEmpty)
                  Positioned(
                    top: height * 0.18,
                    left: 16,
                    right: 16,
                    child: Material(
                      elevation: 2.0,
                      color:!isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestionsAlli.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(suggestionsAlli[index],
                              style: TextStyle(
                                color:isDarkMode
                                    ? CupertinoColors.white.withOpacity(0.5)
                                    : CupertinoColors.black.withOpacity(0.5),
                              ),
                            ),
                            onTap: () => addItemAlli(suggestionsAlli[index]),
                          );
                        },
                      ),
                    ),
                  ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: selectedItemsAlli.map((item) {
                    return Chip(
                      label: Text(item,style: TextStyle(color:isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),),),
                      backgroundColor: isDarkMode? Color(0xff141218) : Colors.white,
                      deleteIcon: Icon(Icons.close,color: isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),),
                      onDeleted: () => removeItemAlli(item),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.historyDoses),
                SizedBox(height: height * 0.01),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.055,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: searchMedicaController,
                          padding: EdgeInsets.zero,
                          style: GoogleFonts.aBeeZee(
                            color: isDarkMode
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          placeholderStyle: GoogleFonts.aBeeZee(
                            color: isDarkMode
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          placeholder: appLocalizations.historyDoses,
                          onSubmitted: (value) => addItemMedica(value),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          CupertinoIcons.arrow_up_circle,
                          color: isDarkMode
                              ? CupertinoColors.white.withOpacity(0.5)
                              : CupertinoColors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                if (suggestionsMedica.isNotEmpty)
                  Positioned(
                    top: height * 0.3,
                    left: 16,
                    right: 16,
                    child: Material(
                      color:!isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestionsMedica.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(suggestionsMedica[index],
                              style: TextStyle(
                                color:isDarkMode
                                    ? CupertinoColors.white.withOpacity(0.5)
                                    : CupertinoColors.black.withOpacity(0.5),
                              ),
                            ),
                            onTap: () => addItemMedica(suggestionsMedica[index]),
                          );
                        },
                      ),
                    ),
                  ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: selectedItemsMedica.map((item) {
                    return Chip(
                      label: Text(item,style: TextStyle(color:isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),),),
                      backgroundColor: isDarkMode? Color(0xff141218) : Colors.white,
                      deleteIcon: Icon(Icons.close,color: isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),),
                      onDeleted: () => removeItemMedica(item),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.instructions),
                SizedBox(height: height * 0.01),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.055,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoTextField(
                          controller: searchEnviController,
                          padding: EdgeInsets.zero,
                          style: GoogleFonts.aBeeZee(
                            color: isDarkMode
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          placeholderStyle: GoogleFonts.aBeeZee(
                            color: isDarkMode
                                ? CupertinoColors.white.withOpacity(0.5)
                                : CupertinoColors.black.withOpacity(0.5),
                            fontSize: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          placeholder: appLocalizations.instructions
                          ,
                          onSubmitted: (value) => addItemEnvi(value),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(2),
                        child: Icon(
                          CupertinoIcons.arrow_up_circle,
                          color: isDarkMode
                              ? CupertinoColors.white.withOpacity(0.5)
                              : CupertinoColors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                if (suggestionsEnvi.isNotEmpty)
                  Positioned(
                    top: height * 0.42,
                    left: 16,
                    right: 16,
                    child: Material(
                      color:!isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestionsEnvi.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(suggestionsEnvi[index],
                              style: TextStyle(
                                color:isDarkMode
                                    ? CupertinoColors.white.withOpacity(0.5)
                                    : CupertinoColors.black.withOpacity(0.5),
                              ),
                            ),
                            onTap: () => addItemEnvi(suggestionsEnvi[index]),
                          );
                        },
                      ),
                    ),
                  ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: selectedItemsEnvi.map((item) {
                    return Chip(
                      label: Text(item,style: TextStyle(color:isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),),),
                      backgroundColor: isDarkMode? Color(0xff141218) : Colors.white,
                      deleteIcon: Icon(Icons.close,color: isDarkMode
                          ? CupertinoColors.white.withOpacity(0.5)
                          : CupertinoColors.black.withOpacity(0.5),),
                      onDeleted: () => removeItemEnvi(item),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: height*0.02,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.priseEnCharge),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text(appLocalizations.medical,style: TextStyle(color:isDarkMode
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),)),
                        value: 'médicale',
                        groupValue: _priseEnCharge,
                        onChanged: (value) {
                          setState(() {
                            _priseEnCharge = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: AutoSizeText(maxLines: 1, appLocalizations.paraMedical,style: TextStyle(color:isDarkMode
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),)),
                        value: 'paramédicale',
                        groupValue: _priseEnCharge,
                        onChanged: (value) {
                          setState(() {
                            _priseEnCharge = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                buildLabel(appLocalizations.correspondance),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text(appLocalizations.reference,style: TextStyle(color:isDarkMode
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),)),
                        value: 'référence',
                        groupValue: _correspondances,
                        onChanged: (value) {
                          setState(() {
                            _correspondances = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text(appLocalizations.coreference,style: TextStyle(color:isDarkMode
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),)),
                        value: 'contre référence',
                        groupValue: _correspondances,
                        onChanged: (value) {
                          setState(() {
                            _correspondances = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
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
                      appLocalizations.precedent,
                      style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    DocMedical.setProgress(context, 0.5);
                    DocMedical.setIndex(context, 2);
                  },
                ),
                CupertinoButton(
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      appLocalizations.suivant,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    DocMedical.setProgress(context, 1);
                    DocMedical.setIndex(context, 4);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}