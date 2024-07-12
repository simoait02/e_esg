import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Creatediscussion03 extends StatefulWidget {
  const Creatediscussion03({super.key});

  @override
  State<Creatediscussion03> createState() => _Creatediscussion03State();
}

class _Creatediscussion03State extends State<Creatediscussion03> {
  String label = "Select meeting date";
  DateTime selectedDateTime = DateTime.now();
  DateTime tempSelectedDateTime = DateTime.now();
  String label1 = "Select meeting time";
  DateTime selectedTime = DateTime.now();
  DateTime tempSelectedTime = DateTime.now();
  bool male = false;
  bool female = false;
  int discType=0;

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
  void updateDate(DateTime newDate) {
    setState(() {
      selectedDateTime = newDate;
      label = DateFormat.yMMMMd().format(selectedDateTime);
    });
  }

  void updateTime(DateTime newTime) {
    setState(() {
      selectedTime = newTime;
      label1 = DateFormat.Hm().format(selectedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          height: height*0.05,
          child: CupertinoSegmentedControl<int>(
            selectedColor: Color(0xff0b40ff),
            pressedColor: Colors.blue.withOpacity(0.2),
            groupValue: discType,
            unselectedColor: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.2):CupertinoColors.black.withOpacity(0.2),
            children: {
              0: Container(child: Text('Private',style: GoogleFonts.poppins(
                textStyle: TextStyle(color:Cardi.isDarkMode.value?CupertinoColors.white:CupertinoColors.black, fontWeight: FontWeight.w500)
              ),)),
              1: Container(child: Text('Public',style: GoogleFonts.poppins(
          textStyle: TextStyle(color:Cardi.isDarkMode.value?CupertinoColors.white:CupertinoColors.black,fontWeight: FontWeight.w500 )))),
            },
            onValueChanged: (int value) {
              setState(() {
                discType = value;
              });
            },
          ),
        ),
        SizedBox(height: height*0.05),
        discType==0? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel("Choisissez vos Médecins"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: height * 0.055,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      padding: EdgeInsets.zero,
                      style: GoogleFonts.aBeeZee(
                        color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                        fontSize: 15,
                      ),
                      placeholderStyle: GoogleFonts.aBeeZee(
                        color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                        fontSize: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.all(2),
                      child: Icon(CupertinoIcons.search,color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                      )
                  ),
                ],
              ),
            ),
          ],
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel("Choisissez les Spécialités"),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: height * 0.055,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      padding: EdgeInsets.zero,
                      style: GoogleFonts.aBeeZee(
                        color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                        fontSize: 15,
                      ),
                      placeholderStyle: GoogleFonts.aBeeZee(
                        color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                        fontSize: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(2),
                    child: Icon(CupertinoIcons.search,color: Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        buildLabel("Date"),
        GestureDetector(
          onTap: () {
            tempSelectedDateTime = selectedDateTime;
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  width: width,
                  height: height*0.35,
                  color:Cardi.isDarkMode.value?CupertinoColors.black.withOpacity(0.8): CupertinoColors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoButton(
                            child: const Text(
                              "Done",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              updateDate(tempSelectedDateTime);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: CupertinoTheme(
                          data:  CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                                dateTimePickerTextStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color:Cardi.isDarkMode.value? Colors.white:Colors.black,
                                    fontSize: 20,
                                  ),
                                )
                            ),
                          ),
                          child: CupertinoDatePicker(
                            initialDateTime: selectedDateTime,
                            onDateTimeChanged: (DateTime newDate) {
                              tempSelectedDateTime = newDate;
                            },
                            mode: CupertinoDatePickerMode.date,
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: height * 0.055,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(
                color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label),
                Icon(CupertinoIcons.calendar,color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        buildLabel("Time"),
        GestureDetector(
          onTap: () {
            tempSelectedTime = selectedTime;
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  width: width,
                  height: 250,
                  color:Cardi.isDarkMode.value?CupertinoColors.black.withOpacity(0.5): CupertinoColors.white.withOpacity(0.5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoButton(
                            child: const Text(
                              "Done",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              updateTime(tempSelectedTime);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: CupertinoTheme(
                          data:  CupertinoThemeData(
                            textTheme: CupertinoTextThemeData(
                                dateTimePickerTextStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color:Cardi.isDarkMode.value? Colors.white:Colors.black,
                                    fontSize: 20,
                                  ),
                                )
                            ),
                          ),
                          child: CupertinoDatePicker(
                            initialDateTime: selectedTime,
                            onDateTimeChanged: (DateTime newTime) {
                              tempSelectedTime = newTime;
                            },
                            mode: CupertinoDatePickerMode.time,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: height * 0.055,
            width: width,
            decoration: BoxDecoration(
              border: Border.all(
                color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label1),
                Icon(CupertinoIcons.time,color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
