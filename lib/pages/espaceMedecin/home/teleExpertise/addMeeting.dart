import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddMeeting extends StatefulWidget {
  const AddMeeting({Key? key}) : super(key: key);

  @override
  State<AddMeeting> createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  final FocusNode _titleFocusNode = FocusNode();
  bool _titleHasFocus = false;

  String label = "Select meeting date";
  DateTime selectedDateTime = DateTime.now();
  DateTime tempSelectedDateTime = DateTime.now();
  String label1 = "Select meeting time";
  DateTime selectedTime = DateTime.now();
  DateTime tempSelectedTime = DateTime.now();

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
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Cardi.isDarkMode.value?Color(0xff181a1b): Colors.white,
        previousPageTitle: "Back",
        middle:  Text('Add Meeting',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color:Cardi.isDarkMode.value?Colors.white:Colors.black,
            )
          ),
        ),
        trailing: GestureDetector(
          onTap: () {},
          child: Text(
            "Done",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create a meeting",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              buildLabel("Title"),
              buildTextField(height, "", _titleFocusNode, _titleHasFocus,Cardi.isDarkMode.value),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLabel("Ajouter Participant "),
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.add))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
