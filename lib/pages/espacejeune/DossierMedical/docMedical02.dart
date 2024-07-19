import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_esg/Data/maladie_list.dart';
import 'package:e_esg/Data/chirurgical_list.dart';
import 'package:e_esg/Data/familliaux_list.dart';

class Docmedical02 extends StatefulWidget {
  const Docmedical02({super.key});

  @override
  State<Docmedical02> createState() => _Docmedical02State();
}

class _Docmedical02State extends State<Docmedical02> {
  TextEditingController searchMediController = TextEditingController();
  TextEditingController fromMediController = TextEditingController();
  TextEditingController toMediController = TextEditingController();

  TextEditingController searchChuriController = TextEditingController();
  TextEditingController fromChuriController = TextEditingController();
  TextEditingController toChuriController = TextEditingController();

  TextEditingController searchFamillController = TextEditingController();
  TextEditingController fromFamillController = TextEditingController();
  TextEditingController toFamillController = TextEditingController();

  List<String> suggestionsMedi = [];
  List<Map<String, String>> selectedItemsMedi = [];

  List<String> suggestionsChuri = [];
  List<Map<String, String>> selectedItemsChuri = [];

  List<String> suggestionsFamill = [];
  List<Map<String, String>> selectedItemsFamill = [];

  @override
  void initState() {
    super.initState();
    searchMediController.addListener(() {
      filterSearchResultsMedi(searchMediController.text);
    });
    searchChuriController.addListener(() {
      filterSearchResultsChuri(searchChuriController.text);
    });
    searchFamillController.addListener(() {
      filterSearchResultsFamill(searchFamillController.text);
    });
  }

  void filterSearchResultsFamill(String query) {
    List<String> dummySearchList = maladiesFamiliales;
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        suggestionsFamill.clear();
        suggestionsFamill.addAll(dummyListData);
      });
    } else {
      setState(() {
        suggestionsFamill.clear();
      });
    }
  }

  void filterSearchResultsChuri(String query) {
    List<String> dummySearchList = surgicalOperations;
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        suggestionsChuri.clear();
        suggestionsChuri.addAll(dummyListData);
      });
    } else {
      setState(() {
        suggestionsChuri.clear();
      });
    }
  }

  void filterSearchResultsMedi(String query) {
    List<String> dummySearchList = maladies.sublist(1); // Exclude "Tout"
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        suggestionsMedi.clear();
        suggestionsMedi.addAll(dummyListData);
      });
    } else {
      setState(() {
        suggestionsMedi.clear();
      });
    }
  }

  void addItemFamill(String item, String from, String to) {
    if(item.isNotEmpty&&from.isNotEmpty&&to.isNotEmpty){
      setState(() {
        selectedItemsFamill.add({'item': item, 'from': from, 'to': to});
        searchFamillController.clear();
        fromFamillController.clear();
        toFamillController.clear();
        suggestionsFamill.clear();
      });
    }else{
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.fillCorrectly);
    }
  }

  void addItemChuri(String item, String from, String to) {
    if(item.isNotEmpty&&from.isNotEmpty&&to.isNotEmpty) {
      setState(() {
        selectedItemsChuri.add({'item': item, 'from': from, 'to': to});
        searchChuriController.clear();
        fromChuriController.clear();
        toChuriController.clear();
        suggestionsChuri.clear();
      });
    }else{
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.fillCorrectly);
    }
  }

  void addItemMedi(String item, String from, String to) {
    if(item.isNotEmpty&&from.isNotEmpty&&to.isNotEmpty) {
      setState(() {
        selectedItemsMedi.add({'item': item, 'from': from, 'to': to});
        searchMediController.clear();
        fromMediController.clear();
        toMediController.clear();
        suggestionsMedi.clear();
      });
    }else{
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.fillCorrectly);
    }
  }

  void removeItemFamill(String item) {
    setState(() {
      selectedItemsFamill.removeWhere((element) => element['item'] == item);
    });
  }

  void removeItemChuri(String item) {
    setState(() {
      selectedItemsChuri.removeWhere((element) => element['item'] == item);
    });
  }

  void removeItemMedi(String item) {
    setState(() {
      selectedItemsMedi.removeWhere((element) => element['item'] == item);
    });
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 20,
          color: Color(0xff4E57CD),
        ),
      ),
    );
  }

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
                appLocalizations!.medicalHistory,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.antecedantMedicaux),
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
                          controller: searchMediController,
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
                          placeholder: appLocalizations.antecedantMedicaux,
                          onSubmitted: (value) => addItemMedi(
                            value,
                            fromMediController.text,
                            toMediController.text,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          addItemMedi(searchMediController.text, fromMediController.text, toMediController.text);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),

                if (suggestionsMedi.isNotEmpty)
                  Material(
                    elevation: 2.0,
                    color: !isDarkMode
                        ? CupertinoColors.white.withOpacity(0.5)
                        : CupertinoColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestionsMedi.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            suggestionsMedi[index],
                            style: TextStyle(
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                          ),
                          onTap: () {
                            searchMediController.text=suggestionsMedi[index];
                            suggestionsMedi.clear();
                          },
                        );
                      },
                    ),
                  ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        style: GoogleFonts.inter(
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
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        controller: fromMediController,
                        placeholder: appLocalizations.from,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CupertinoTextField(
                        style: GoogleFonts.inter(
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
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        controller: toMediController,
                        placeholder: appLocalizations.to,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: selectedItemsMedi.map((item) {
                    return Chip(
                      backgroundColor: isDarkMode ? Color(0xff141218) : Colors.white,
                      label: Text('${item['item']} (${item['from']} - ${item['to']})',style: TextStyle(
                        color: isDarkMode
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),
                      ),),
                      onDeleted: () {
                        removeItemMedi(item['item']!);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.antecedantChirugi),
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
                          controller: searchChuriController,
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
                          placeholder: appLocalizations.antecedantChirugi,
                          onSubmitted: (value) => addItemChuri(
                            value,
                            fromChuriController.text,
                            toChuriController.text,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          addItemChuri(searchChuriController.text, fromChuriController.text, toChuriController.text);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                if (suggestionsChuri.isNotEmpty)
                  Material(
                    elevation: 2.0,
                    color: !isDarkMode
                        ? CupertinoColors.white.withOpacity(0.5)
                        : CupertinoColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestionsChuri.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            suggestionsChuri[index],
                            style: TextStyle(
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                          ),
                          onTap: () {
                            searchChuriController.text=suggestionsChuri[index];
                            suggestionsChuri.clear();
                          },
                        );
                      },
                    ),
                  ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        style: GoogleFonts.inter(
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
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        controller: fromChuriController,
                        placeholder: appLocalizations.from,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CupertinoTextField(
                        style: GoogleFonts.inter(
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
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        controller: toChuriController,
                        placeholder: appLocalizations.to,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: selectedItemsChuri.map((item) {
                    return Chip(
                      backgroundColor: isDarkMode ? Color(0xff141218) : Colors.white,
                      label: Text('${item['item']} (${item['from']} - ${item['to']})',style: TextStyle(
                        color: isDarkMode
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),
                      ),),
                      onDeleted: () {
                        removeItemChuri(item['item']!);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel(appLocalizations.antecedantFamil),
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
                          controller: searchFamillController,
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
                          placeholder: appLocalizations.antecedantFamil,
                          onSubmitted: (value) => addItemFamill(
                            value,
                            fromFamillController.text,
                            toFamillController.text,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          addItemFamill(searchFamillController.text, fromFamillController.text, toFamillController.text);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                if (suggestionsFamill.isNotEmpty)
                  Material(
                    elevation: 2.0,
                    color: !isDarkMode
                        ? CupertinoColors.white.withOpacity(0.5)
                        : CupertinoColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestionsFamill.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            suggestionsFamill[index],
                            style: TextStyle(
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                          ),
                          onTap: () {
                            searchFamillController.text=suggestionsFamill[index];
                            suggestionsFamill.clear();
                          },
                        );
                      },
                    ),
                  ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        style: GoogleFonts.inter(
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
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        controller: fromFamillController,
                        placeholder: appLocalizations.from,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CupertinoTextField(
                        style: GoogleFonts.inter(
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
                              color: isDarkMode
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        controller: toFamillController,
                        placeholder: appLocalizations.to,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: selectedItemsFamill.map((item) {
                    return Chip(
                      backgroundColor: isDarkMode ? Color(0xff141218) : Colors.white,
                      label: Text('${item['item']} (${item['from']} - ${item['to']})',style: TextStyle(
                        color: isDarkMode
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),
                      ),),
                      onDeleted: () {
                        removeItemFamill(item['item']!);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.06,
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
                    DocMedical.setProgress(context, 0.1);
                    DocMedical.setIndex(context, 0);
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
                    DocMedical.setProgress(context, 0.5);
                    DocMedical.setIndex(context, 2);
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
