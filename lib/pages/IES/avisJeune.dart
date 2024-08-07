import 'dart:core';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../../Widgets/text_field.dart';
import '../espacejeune/SideBar/Settings.dart';
class Avisjeune extends StatefulWidget {
  const Avisjeune({super.key});

  @override
  State<Avisjeune> createState() => _AvisjeuneState();
}

class _AvisjeuneState extends State<Avisjeune> {
  double turns = 0.0;
  double turns1 = 0.0;
  bool isFocused = false;
  FocusNode _focusNode = FocusNode();
  bool isFocused1 = false;
  FocusNode _focusNode1 = FocusNode();
  bool isFocused3 = false;
  FocusNode _focusNode3 = FocusNode();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _searchController1 = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();

  List<String> filteredList = [];
  List<String> filteredList1 = [];
  List<String> list=[
    "Excellent",
    "Bon",
    "Passable",
    "Mauvais",
    "Très mauvais"
  ];
  List<String> list1=[
    "Oui",
    "Non"
  ];
  @override
  void initState() {
    super.initState();
    filteredList = list;
    filteredList1 = list1;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isFocused = true;
          if (turns == 0.0) turns = 1 / 2;
        });
      } else {
        setState(() {
          if (turns == 1 / 2) turns = 0.0;
          isFocused = false;
          _filterSuggestions();
        });
      }
    });
    _focusNode1.addListener(() {
      if (_focusNode1.hasFocus) {
        setState(() {
          isFocused1 = true;
          if (turns1 == 0.0) turns1 = 1 / 2;
        });
      } else {
        setState(() {
          if (turns1 == 1 / 2) turns1 = 0.0;
          isFocused1 = false;
          _filterSuggestions1();
        });
      }
    });
    _focusNode3.addListener(() {
      if (_focusNode3.hasFocus) {
        setState(() {
          isFocused3 = true;
        });
      } else {
        setState(() {
          isFocused3 = false;
        });
      }
    });
    _searchController.addListener(() {
      _filterSuggestions();
    });
    _searchController1.addListener(() {
      _filterSuggestions1();
    });
  }
  void _filterSuggestions() {
    setState(() {
      if (_searchController.text.isEmpty) {
        filteredList = list;
      } else {
        filteredList = list
            .where((e) =>
            e.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }
  void _filterSuggestions1() {
    setState(() {
      if (_searchController1.text.isEmpty) {
        filteredList1 = list1;
      } else {
        filteredList1 = list1
            .where((e) =>
            e.toLowerCase().contains(_searchController1.text.toLowerCase()))
            .toList();
      }
    });
  }
  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    _focusNode1.dispose();
    _searchController1.dispose();
    _focusNode3.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double sectionPadding = screenWidth * 0.04;
    double titleFontSize = screenWidth * 0.06;
    return Scaffold(backgroundColor: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
    body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(sectionPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      "Ce que vous pensez du Live...",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        fontSize: titleFontSize,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Comment évalueriez vouz le live?",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 51,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isFocused ? Color(0xFF2E37A4) : Color(0xFFEAEBF6),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SearchField<String>(
                                  controller: _searchController,
                                  focusNode: _focusNode,
                                  autofocus: false,
                                  hint: "Sélectionnez une des réponses",
                                  itemHeight: 50,
                                  maxSuggestionsInViewPort: 6,
                                  suggestions: filteredList
                                      .map(
                                        (e) => SearchFieldListItem<String>(
                                      e,
                                      item: e,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  searchInputDecoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                  offset: Offset(0, 50),
                                  suggestionsDecoration: SuggestionDecoration(
                                    color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
                                    borderRadius: BorderRadius.circular(10),
                                    width: MediaQuery.of(context).size.width - 100,
                                  ),
                                  onSuggestionTap: (SearchFieldListItem<String> suggestion) {
                                    setState(() {
                                      _focusNode.unfocus();
                                    });
                                  },
                                  onTapOutside: (PointerDownEvent event) {
                                    _focusNode.unfocus();
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: AnimatedRotation(
                                  turns: turns,
                                  duration: const Duration(milliseconds: 400),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isFocused) {
                                          _focusNode.unfocus();
                                          turns = 0;
                                        } else {
                                          _focusNode.requestFocus();
                                          turns = 1 / 2;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      child: Image.asset("assets/images/flèche1.png",color:SettingsYong.isDarkMode.value ? Color(0xFFEAEBF6) : Color(0xff141218),),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recommenderiez-vous cette session a d'autres persones?",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 51,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isFocused1 ? Color(0xFF2E37A4) : Color(0xFFEAEBF6),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SearchField<String>(
                                  controller: _searchController1,
                                  focusNode: _focusNode1,
                                  hint: "Sélectionnez une des réponses",
                                  autofocus: false,
                                  itemHeight: 50,
                                  maxSuggestionsInViewPort: 6,
                                  suggestions: filteredList1
                                      .map(
                                        (e) => SearchFieldListItem<String>(
                                      e,
                                      item: e,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                      .toList(),
                                  searchInputDecoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                  offset: Offset(0, 50),
                                  suggestionsDecoration: SuggestionDecoration(
                                    color: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
                                    borderRadius: BorderRadius.circular(10),
                                    width: MediaQuery.of(context).size.width - 100,
                                  ),
                                  onSuggestionTap: (SearchFieldListItem<String> suggestion) {
                                    setState(() {
                                      _focusNode1.unfocus();
                                    });
                                  },
                                  onTapOutside: (PointerDownEvent event) {
                                    _focusNode1.unfocus();
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: AnimatedRotation(
                                  turns: turns1,
                                  duration: const Duration(milliseconds: 400),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isFocused1) {
                                          _focusNode1.unfocus();
                                          turns1 = 0;
                                        } else {
                                          _focusNode1.requestFocus();
                                          turns1 = 1 / 2;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      child: Image.asset("assets/images/flèche1.png",color:SettingsYong.isDarkMode.value ? Color(0xFFEAEBF6) : Color(0xff141218),),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(title: "Y-a-t-il un sujet que vous aimeriez voir abordé en direct?",height: 15,),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Exprimez-vous librement",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 151,
                          padding: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isFocused3 ? Color(0xFF2E37A4) : Color(0xFFEAEBF6),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: _textEditingController,
                            focusNode: _focusNode3,
                            autofocus: true,
                            cursorColor: Color(0xFF2E37A4),
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: null, // Allows unlimited lines
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            onTapOutside: (PointerDownEvent event) {
                              _focusNode3.unfocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Spacer(),
                        ElevatedButton(
                          onPressed:(){
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Annuler",
                            style:TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: titleFontSize-5) ,
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF2E37A4),
                              backgroundColor: SettingsYong.isDarkMode.value ? Color(0xff141218) : Color(0xffF5F5F6),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Color(0xFF2E37A4),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          onPressed: (){},
                          child: Text(
                            "Soumettre",
                            style:TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: titleFontSize-5) ,
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF2E37A4),
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),);
  }
}
