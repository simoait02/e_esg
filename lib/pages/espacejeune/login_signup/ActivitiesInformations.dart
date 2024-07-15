import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Cardi.dart';

class Activitiesinformations extends StatefulWidget {
  final Function(double, double) onBackTapped;
  final Function(double, double) onScolarityTapped;
  final Function(double, double) onPasswordTapped;
  final Function(double, double) onLoginTapped;

  Activitiesinformations({
    Key? key,
    required this.onBackTapped,
    required this.onScolarityTapped,
    required this.onPasswordTapped,
    required this.onLoginTapped,
  }) : super(key: key);

  @override
  State<Activitiesinformations> createState() => _ActivitiesinformationsState();
}

class _ActivitiesinformationsState extends State<Activitiesinformations> {
  int _value = 0;
  String dropdownValue = 'Primaire';
  bool isFocused = false;
  FocusNode _focusNode = FocusNode();
  bool hasSelected=false;
  bool scolarity=true;
  final FocusNode _cinFocusNode = FocusNode();
  bool _cinHasFocus = false;
  final FocusNode _cneFocusNode = FocusNode();
  bool _cneHasFocus = false;
  final FocusNode _codeMassarFocusNode = FocusNode();
  bool _codeMassarHasFocus = false;
  final FocusNode _lastStudFocusNode = FocusNode();
  bool _lastStudHasFocus = false;
  final FocusNode _stateActuFocusNode = FocusNode();
  bool _stateActuHasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
    _cinFocusNode.addListener(() {
      setState(() {
        _cinHasFocus = _cinFocusNode.hasFocus;
      });
    });
    _cneFocusNode.addListener(() {
      setState(() {
        _cneHasFocus = _cneFocusNode.hasFocus;
      });
    });
    _codeMassarFocusNode.addListener(() {
      setState(() {
        _codeMassarHasFocus = _codeMassarFocusNode.hasFocus;
      });
    });
    _lastStudFocusNode.addListener(() {
      setState(() {
        _lastStudHasFocus = _lastStudFocusNode.hasFocus;
      });
    });
    _stateActuFocusNode.addListener(() {
      setState(() {
        _stateActuHasFocus = _stateActuFocusNode.hasFocus;
      });
    });
  }
  Widget buildTextField(double width,double height, String placeholder, FocusNode focusNode, bool hasFocus,bool isDarkMode) {
    return Container(
      width: width * 0.8,
      height: height*0.065,
      child: CupertinoTextField(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasFocus?Color(0xFF2E37A4) : isDarkMode ? CupertinoColors.white.withOpacity(0.5) : Color(0xFFEAEBF6),
            width: 2,
          ),
        ),
        focusNode: focusNode,
        placeholder: placeholder,
        style:TextStyle(
          color: isDarkMode?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left:30),
                    child:  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: height*0.07,
                        width: width*0.3,
                        child: AutoSizeText(
                          "Sign up",
                          style: TextStyle(
                              color: isDarkMode?Colors.white:Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: "poppins"
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.01,
                  ),
                  Visibility(
                      visible: true,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        width: width ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height*0.03,
                                margin: EdgeInsets.only(left:10) ,
                                child: AutoSizeText("CIN",
                                  style: TextStyle(color: isDarkMode?Colors.white:Colors.black),)),
                            buildTextField(width,height, "", _cinFocusNode, _cinHasFocus,isDarkMode),
                          ],
                        ),
                      ),),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height*0.03,
                          margin: EdgeInsets.only(left:30) ,
                          child: AutoSizeText("Scolarite",
                            style: TextStyle(color: isDarkMode?Colors.white:Colors.black),)),),
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
                                    CardiJeune.q = 0.7;
                                    CardiJeune.top = 0.1;
                                    widget.onScolarityTapped(CardiJeune.q, CardiJeune.top);
                                    scolarity=true;
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
                                "Oui",
                                style: TextStyle(fontFamily: "Poppins",color: isDarkMode? Colors.white:Colors.black),
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
                                    CardiJeune.q = 0.7;
                                    CardiJeune.top = 0.1;
                                    widget.onScolarityTapped(CardiJeune.q, CardiJeune.top);
                                    scolarity=false;
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
                                "Non",
                                style: TextStyle(fontFamily: "Poppins",color: isDarkMode? Colors.white:Colors.black),
                              ),
                            ],
                          ),
                        ],
                      )),
                  Visibility(
                    visible: scolarity&&hasSelected,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText("Niveau de scolarite Actuel",style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: isDarkMode?Colors.white:Colors.black,
                              ),),
                              Container(
                                height: height*0.065,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: !isFocused ? Color(0xFF2E37A4) : Color(0xFFEAEBF6),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    AutoSizeText(dropdownValue,style: TextStyle(
                                        fontSize: 14,
                                        color: isDarkMode?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
                                    ),),
                                    Spacer(),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        focusNode: _focusNode,
                                        icon: Image.asset(
                                          "assets/images/flèche1.png",
                                          height: 15,
                                          width: 15,color: isDarkMode ? CupertinoColors.white.withOpacity(0.5) : Color(0xFFEAEBF6),
                                        ),
                                        dropdownColor: Colors.white,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: const [
                                          DropdownMenuItem(
                                            child: Text('Primaire'),
                                            value: 'Primaire',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Secondaire'),
                                            value: 'Secondaire',
                                          ),
                                          DropdownMenuItem(
                                            child: Text('Supérieur'),
                                            value: 'Supérieur',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height*0.02,),
                        Visibility(
                            visible: dropdownValue=='Primaire',
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: height*0.03,
                                    margin: EdgeInsets.only(left:10) ,
                                    child: AutoSizeText("CNE",
                                      style: TextStyle(color: isDarkMode?Colors.white:Colors.black),)),
                                buildTextField(width,height, "", _cneFocusNode, _cneHasFocus,isDarkMode),
                              ],
                            ),
                        ),
                        Visibility(
                            visible: !(dropdownValue=='Primaire'),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: height*0.03,
                                    margin: EdgeInsets.only(left:10) ,
                                    child: AutoSizeText("Code Massar",
                                      style: TextStyle(color: isDarkMode?Colors.white:Colors.black),)),
                                buildTextField(width,height, "", _codeMassarFocusNode, _codeMassarHasFocus,isDarkMode),
                              ],
                            ),),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: (!scolarity)&&hasSelected,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: height*0.03,
                                  margin: EdgeInsets.only(left:10) ,
                                  child: AutoSizeText("Dernier niveau d'etudes",
                                    style: TextStyle(color: isDarkMode?Colors.white:Colors.black),)),
                              buildTextField(width,height, "", _lastStudFocusNode, _lastStudHasFocus,isDarkMode),
                            ],
                          ),
                          SizedBox(height: height*0.02,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: height*0.03,
                                  margin: EdgeInsets.only(left:10) ,
                                  child: AutoSizeText("Situation Actuelle",
                                    style: TextStyle(color: isDarkMode?Colors.white:Colors.black),)),
                              buildTextField(width,height, "", _stateActuFocusNode, _stateActuHasFocus,isDarkMode),
                            ],
                          ),
                        ],
                      )),
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
                                child: const Text(
                                  "Précédent",
                                  style: TextStyle(color: Color(0xff4E57CD), fontSize: 20),
                                )),
                            onPressed: () {
                              widget.onBackTapped(0.8,0.1);
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
                                  child: const AutoSizeText(
                                    "Suivant",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                              onPressed: () {
                                setState(() {
                                  CardiJeune.q = 0.55;
                                  CardiJeune.top = 0.1;
                                  widget.onPasswordTapped(CardiJeune.q,CardiJeune.top);
                                });

                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]));
  }
}
