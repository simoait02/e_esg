import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:e_esg/Widgets/text_field.dart';
import '../../IES/statistiques.dart';
import 'Card.dart';

class Signup extends StatefulWidget {
  final Function(double, double) onSigninTapped;
  final Function() onContinueTapped;

  Signup({super.key, required this.onSigninTapped,required this.onContinueTapped});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FocusNode _nomFocusNode = FocusNode();
  final FocusNode _prenomFocusNode = FocusNode();
  bool _nomHasFocus = false;
  bool _prenomHasFocus = false;
  int _value=0;

  TextEditingController _dateController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _nomFocusNode.addListener(() {
      setState(() {
        _nomHasFocus = _nomFocusNode.hasFocus;
      });
    });
    _prenomFocusNode.addListener(() {
      setState(() {
        _prenomHasFocus = _prenomFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nomFocusNode.dispose();
    _prenomFocusNode.dispose();
    super.dispose();
  }

  Widget buildTextField(double width,double height, String placeholder, FocusNode focusNode, bool hasFocus,bool isDarkMode) {
    return Container(
      width: width * 0.8,
      height: height*0.055,
      child: CupertinoTextField(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasFocus?Color(0xFF2E37A4) : isDarkMode ? CupertinoColors.white : Color(0xFFEAEBF6),
            width: 2,
          ),
        ),
        focusNode: focusNode,
        placeholder: placeholder,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }
  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF99EDE9),
              onSurface: Color(0xFF333448),
              surface: Color(0xFFF4F5FA),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontFamily: "Poppins"),
              titleLarge: TextStyle(fontFamily: "Poppins"),
              labelLarge: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w400, fontSize: 20),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF4A5BF6),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      _dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
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
                  height: height*0.07,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: "Poppins"
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Align(alignment: Alignment.centerLeft ,
                    child: Container(
                        height: height*0.025,
                        margin: EdgeInsets.only(left:30) ,
                        child: const AutoSizeText("Sexe")
                    )
                ),
                Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(value: 1, groupValue: _value, onChanged: (value) {
                              setState(() {
                                _value=value!;
                              });
                            },
                              fillColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Color(0xff00D3C7);
                                  }
                                  return null;
                                },),
                            ),
                            AutoSizeText("Femme",style: TextStyle(
                                fontFamily: "Poppins"
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(value: 2, groupValue: _value, onChanged: (value) {setState(() {
                              _value=value!;
                            });},
                              fillColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Color(0xff00D3C7);
                                  }
                                  return null;
                                },),),
                            const SizedBox(height: 4,),
                            AutoSizeText("Homme",style: TextStyle(
                              fontFamily: "Poppins"
                            ),),
                          ],
                        ),
                      ],
                    )
                ),

                const SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: const AutoSizeText("Nom",
                                style: TextStyle(fontFamily: "Poppins"),)),
                            buildTextField(width * 0.5,height, "", _nomFocusNode, _nomHasFocus,isDarkMode),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: height*0.025,
                                margin: EdgeInsets.only(left:10) ,
                                child: const AutoSizeText("Prénom",
                                    style: TextStyle(fontFamily: "Poppins"))),
                            buildTextField(width * 0.5, height,"", _prenomFocusNode, _prenomHasFocus,isDarkMode),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                CustomTextField(
                  height: 0,
                  title: "Date de naissance",
                  controller: _dateController,
                  onTap: _showDatePicker,
                  iconButton: IconButton(
                    onPressed: _showDatePicker,
                    highlightColor: Colors.transparent,
                    icon: Container(
                      width: iconButtonSize+50,
                      height: iconButtonSize+50,
                      child: SvgPicture.asset('assets/images/calendar_icon.svg'),
                    ),
                  ),
                ),
                CustomTextField(title: "Adresse e-mail", height: 0),
                CustomTextField(title: "Numéro de téléphone", height: 0),
                const SizedBox(height: 10,),
              ],
            ),

            Column(
              children: [
                CupertinoButton(
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                            width: width * 0.3,
                            height: height*0.06,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [Color(0xff4E57CD), Color(0xff0c40a4)]),
                                borderRadius: BorderRadius.circular(40)),
                            alignment: Alignment.center,
                            child: const AutoSizeText(
                              "Suivant",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      ],
                    ),
                    onPressed: () {
                      Cardi.q = 0.45;
                      Cardi.top = 0.25;
                      widget.onContinueTapped();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20,),
                    Container(
                      height: height*0.025,
                      child: const AutoSizeText(
                        "Vous avez déja un compte?",
                        style: TextStyle(fontFamily: "Inter",color: Color(0xff9999A3),
    fontWeight: FontWeight.w400,),
                      ),
                    ),
                    const SizedBox(width: 2,),
                    GestureDetector(
                      onTap: () {
                        widget.onSigninTapped(0.6, 0.25);
                      },
                      child: Container(
                        height: height*0.025,
                        child: AutoSizeText(
                          "Sign In",
                          style: TextStyle(
                              fontFamily: "Inter",
                              color: isDarkMode? Color(0xff759cd8):Color(0xff3a01de)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
    );
  }
}
