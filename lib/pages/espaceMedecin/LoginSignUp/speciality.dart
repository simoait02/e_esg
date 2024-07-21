import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Cardi.dart';
class Speciality extends StatefulWidget {
  final Function(double, double) onBackTapped;
  final Function(double, double) onSpecialityTapped;
  final Function(double, double) onPasswordTapped;
  const Speciality({
    Key? key,
    required this.onBackTapped,
    required this.onSpecialityTapped,
    required this.onPasswordTapped,
  }) : super(key: key);

  @override
  State<Speciality> createState() => _SpecialityState();
}

class _SpecialityState extends State<Speciality> {
  bool yes1=false;
  bool no1=true;
  bool yes2=false;
  bool no2=true;
  bool isFocused = false;
  FocusNode _focusNode = FocusNode();
  double turns = 0.0;
  static int _value = 0;
  static int _value1 = 0;
  bool speciality=true;
  bool hasSelected=false;


  List<String> specialitiesList =[
    " Cardiologue",
    " Dermatologue",
    " Endocrinologue",
    " Gastro-entérologue",
    " Hématologue",
    " Neurologue",
    " Néphrologue",
    " Ophtalmologue",
    " Pneumologue",
    " Stomatologue",
    "Anatomopathologiste",
    "Oncologue",
    "Psychiatre",
    "Pédopsychiatre",
    "Rhumatologue",
    "Médecin rééducateur",
  ];
  List<String> filteredSpecialitiesList = [];

  @override
  void initState() {
    super.initState();
    filteredSpecialitiesList = specialitiesList;
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
    Cardi.specialiteeController.addListener(() {
      _filterSuggestions();
    });
  }
  void _filterSuggestions() {
    setState(() {
      if (Cardi.specialiteeController.text.isEmpty) {
        filteredSpecialitiesList = specialitiesList;
      } else {
        filteredSpecialitiesList = specialitiesList
            .where((speciality) =>
            speciality.toLowerCase().contains(Cardi.specialiteeController.text.toLowerCase()))
            .toList();
      }
    });
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal:30),
                height: height*0.07,
                child: AutoSizeText(
                  appLocalizations!.signUp,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "poppins",
                      color:Cardi.isDarkMode.value?Colors.white:Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: height * 0.04,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: AutoSizeText(
                  appLocalizations.stateDoc,
                  style: TextStyle(color: Cardi.isDarkMode.value ? Colors.white : Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _value1,
                        onChanged: (value) {
                          setState(() {
                            _value1 = value!;
                          });
                        },
                        fillColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xff00D3C7);
                            }
                            return null;
                          },
                        ),
                      ),
                      AutoSizeText(
                        appLocalizations.oui,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _value1,
                        onChanged: (value) {
                          setState(() {
                            _value1 = value!;
                          });
                        },
                        fillColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Color(0xff00D3C7);
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 4),
                      AutoSizeText(
                        appLocalizations.non,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                  height: height*0.03,
                  margin: EdgeInsets.symmetric(horizontal:30) ,
                  child: AutoSizeText(appLocalizations.gen,
                    style: TextStyle(color:Cardi.isDarkMode.value?Colors.white:Colors.black),
                  )
              ),
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                Cardi.q = 0.45;
                                Cardi.top = 0.25;
                                widget.onSpecialityTapped(Cardi.q, Cardi.top);
                                speciality=false;
                                hasSelected=true;

                              });
      
                            },
                            fillColor:
                            WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Color(0xff00D3C7);
                                }
                                return null;
                              },
                            ),
                          ),
                          AutoSizeText(
                            appLocalizations.oui,
                            style: TextStyle(fontFamily: "Poppins",color: Cardi.isDarkMode.value? Colors.white:Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                Cardi.q = 0.53;
                                Cardi.top = 0.1;
                                widget.onSpecialityTapped(Cardi.q, Cardi.top);
                                speciality=true;
                                hasSelected=true;

                              });
                            },
                            fillColor:
                            WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Color(0xff00D3C7);
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          AutoSizeText(
                            appLocalizations.non,
                            style: TextStyle(fontFamily: "Poppins",color: Cardi.isDarkMode.value? Colors.white:Colors.black),
                          ),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(height: 10,),
              Visibility(
                  visible: speciality&&hasSelected,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(alignment: Alignment.centerLeft ,
                      child: Container(
                          height: height*0.025,
                          margin: const EdgeInsets.only(left:30) ,
                          child: AutoSizeText(appLocalizations.speciality,
                            style: TextStyle(color: Cardi.isDarkMode.value?Colors.white:Colors.black),))),
                  Container(
                    height: 51,
                    margin: EdgeInsets.all(10),
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
                            controller: Cardi.specialiteeController,
                            focusNode: _focusNode,
                            autofocus: false,
                            searchStyle: TextStyle(color:Cardi.isDarkMode.value? Colors.white:Colors.black),
                            itemHeight: 40,
                            maxSuggestionsInViewPort: 4,
                            suggestions:  filteredSpecialitiesList
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
                              color: Cardi.isDarkMode.value?Color(0xff9196CD):Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              width: MediaQuery.of(context).size.width - 100,
                            ),
                            onSuggestionTap: (SearchFieldListItem<String> suggestion) {
                              setState(() {
                                _focusNode.unfocus();
                                Cardi.q = 0.53;
                                Cardi.top = 0.1;
                                widget.onSpecialityTapped(Cardi.q, Cardi.top);
                              });
                            },
                            onTapOutside: (PointerDownEvent event) {
                              _focusNode.unfocus();
                              Cardi.q = 0.53;
                              Cardi.top = 0.1;
                              widget.onSpecialityTapped(Cardi.q, Cardi.top);
                            },
                            onTap: (){
                              Cardi.q = 0.75;
                              Cardi.top = 0.1;
                            widget.onSpecialityTapped(Cardi.q, Cardi.top);},
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
                                child: Image.asset("assets/images/flèche1.png"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isFocused ? SizedBox(height: 160) : SizedBox.shrink()

                ],

              ))
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Container(
                        width: width * 0.3,
                        height: height*0.06,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: Color(0xff4E57CD))),
                        alignment: Alignment.center,
                        child: Text(
                          appLocalizations.precedent,
                          style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                        )),
                    onPressed: () {
                      widget.onBackTapped(0.63,0.1);
                    },
                  ),
                  CupertinoButton(
                      child: Container(
                          width: width * 0.3,
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff4E57CD),
                                    Color(0xff0c40a4)
                                  ]),
                              borderRadius: BorderRadius.circular(40)),
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            appLocalizations.suivant,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          )),
                      onPressed: () {
                        if (_value1==1){
                          Cardi.isEsgDoctor=true;
                        }else if (_value1==2){
                          Cardi.isEsgDoctor=false;
                        }
                        if(_value==1){
                          Cardi.isGeneralist=true;
                        }else if (_value==2){
                          Cardi.isGeneralist=false;
                        }
                        if((_value1==1 || _value1==2)&&(_value==1||_value==2)){
                          switch(_value){
                            case 2:{
                              if(Cardi.specialiteeController.text.isNotEmpty){
                                setState(() {
                                  Cardi.q = 0.5;
                                  Cardi.top = 0.1;
                                  widget.onPasswordTapped(Cardi.q,Cardi.top);
                                });
                              }else{
                                Fluttertoast.showToast(msg: "  entrez la specialitée  ",backgroundColor: Colors.red);
                              }
                              break;
                            }
                            case 1:setState(() {
                              Cardi.q = 0.5;
                              Cardi.top = 0.1;
                              widget.onPasswordTapped(Cardi.q,Cardi.top);
                            });
                          }
                        }
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
