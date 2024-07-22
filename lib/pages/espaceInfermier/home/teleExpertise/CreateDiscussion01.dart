import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceInfermier/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Creatediscussion extends StatefulWidget {
  const Creatediscussion({super.key});

  @override
  State<Creatediscussion> createState() => _CreatediscussionState();
}

class _CreatediscussionState extends State<Creatediscussion> {
  final FocusNode _titleFocusNode = FocusNode();
  bool _titleHasFocus = false;
  DateTime selectedTime = DateTime.now();
  DateTime tempSelectedTime = DateTime.now();
  bool male = false;
  bool female = false;

  Widget buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget buildTextField(double height, String placeholder, FocusNode focusNode, bool hasFocus,bool isDarkMode) {
    return Container(
      height: height * 0.055,
      child: CupertinoTextField(
        style: TextStyle(
          color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:isDarkMode?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusNode: focusNode,
        placeholder: placeholder,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appLocalizations!.nomPatient),
                      SizedBox(
                        height: height * 0.055,
                        width: width*0.42,
                        child: CupertinoTextField(
                          style: TextStyle(
                            color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appLocalizations.prenomPatient),
                      SizedBox(
                        height: height * 0.055,
                        width: width*0.42,
                        child: CupertinoTextField(
                          style: TextStyle(
                            color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: height*0.02),
              Container(
                height: height * 0.05,
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      appLocalizations.sex,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    Row(children: [
                      GestureDetector(
                        onTap:(){
                          setState(() {
                            male=true;
                            female=false;
                          });
                          },
                        child: Container(
                          width: width * 0.2,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: male ? Color(0xff0b40ff) : Colors.grey),
                          ),
                          child: AutoSizeText(
                            appLocalizations.male,
                            maxLines: 1,
                            style: TextStyle(color: male ? Color(0xff0b40ff) : Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            female=true;
                            male=false;
                          });
                        },
                        child: Container(
                          width: width * 0.2,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: female ? Color(0xff0b40ff) : Colors.grey),
                          ),
                          child: AutoSizeText(
                            appLocalizations.female,
                            maxLines: 1,
                            style: TextStyle(color: female ? Color(0xff0b40ff) : Colors.grey),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(height: height*0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appLocalizations.agePatient),
                  SizedBox(
                    height: height * 0.055,
                    width: width,
                    child: CupertinoTextField(
                      style: TextStyle(
                        color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                  )
                ],
              ),
              SizedBox(height: height*0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(appLocalizations.patientCase),
                  SizedBox(
                    height: height * 0.055,
                    width: width,
                    child: CupertinoTextField(
                      style: TextStyle(
                        color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:CardiInf.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                  )
                ],
              ),
              SizedBox(height: height*0.02),
              buildLabel(appLocalizations.titleDiscussion),
              buildTextField(height, "", _titleFocusNode, _titleHasFocus,CardiInf.isDarkMode.value),
              SizedBox(height: height*0.02),

            ],
          );
  }
}
