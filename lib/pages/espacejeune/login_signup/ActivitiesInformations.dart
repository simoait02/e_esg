import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e_esg/Widgets/text_field.dart';
import 'Card.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    height: height * 0.07,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                      visible: true,
                      child: CustomTextField(title: "Numéro de carte CIN", height: 0)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: height * 0.025,
                          margin: EdgeInsets.only(left: 30),
                          child: const AutoSizeText(
                            "Scolarité",
                            style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                          ))),
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
                                MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return Color(0xff00D3C7);
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              AutoSizeText(
                                "Oui",
                                style: TextStyle(fontFamily: "Poppins"),
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
                                MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.selected)) {
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
                                style: TextStyle(fontFamily: "Poppins"),
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
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText("Niveau de scolarite Actuel",style: TextStyle(
                                  fontFamily: 'poppins'
                              ),),
                              Container(
                                height: 51,
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
                                        fontSize: 17
                                    ),),
                                    Spacer(),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        focusNode: _focusNode,
                                        icon: Image.asset(
                                          "assets/images/flèche1.png",
                                          height: 20,
                                          width: 20,
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
                        Visibility(
                            visible: dropdownValue=='Primaire',
                            child:CustomTextField(title: 'CNE', height: 0,)),
                        Visibility(
                            visible: !(dropdownValue=='Primaire'),
                            child:CustomTextField(title: 'Code Massar', height: 0,)),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: (!scolarity)&&hasSelected,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          CustomTextField(title: "Dernier niveau d'études", height: 0,),
                          CustomTextField(title: 'Situation Actuelle', height: 0,),
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
                                    color: Colors.white,
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
                                  CardiJeune.q = 0.5;
                                  CardiJeune.top = 0.1;
                                  widget.onPasswordTapped(CardiJeune.q,CardiJeune.top);
                                });

                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: height * 0.025,
                            child: const AutoSizeText(
                              "Vous avez déja un compte?",
                              style: TextStyle(
                                fontFamily: "Inter",
                                color: Color(0xff9999A3),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              CardiJeune.q = 0.6;
                              CardiJeune.top = 0.25;
                              widget.onLoginTapped(CardiJeune.q, CardiJeune.top);
                            },
                            child: Container(
                              height: height * 0.025,
                              child: AutoSizeText(
                                "Sign In",
                                style: TextStyle(
                                    fontFamily: "Inter",
                                    color: Color(0xff3a01de)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]));
  }
}
