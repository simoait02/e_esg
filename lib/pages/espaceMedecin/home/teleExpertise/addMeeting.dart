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
        textStyle: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget buildTextField(
      double height, String placeholder, FocusNode focusNode, bool hasFocus) {
    return Container(
      height: height * 0.055,
      child: CupertinoTextField(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: CupertinoColors.black.withOpacity(0.5),
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
        previousPageTitle: "Back",
        middle: Text('Add Meeting'),
        trailing: GestureDetector(
          onTap: () {
            // Handle save action or navigate back
          },
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
                    color: CupertinoColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              buildLabel("Title"),
              buildTextField(height, "", _titleFocusNode, _titleHasFocus),
              SizedBox(height: 20),
              buildLabel("Date"),
              GestureDetector(
                onTap: () {
                  tempSelectedDateTime = selectedDateTime;
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: width,
                        height: 250,
                        color: CupertinoColors.systemBackground,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoButton(
                                  child: Text(
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
                              child: CupertinoDatePicker(
                                initialDateTime: selectedDateTime,
                                onDateTimeChanged: (DateTime newDate) {
                                  tempSelectedDateTime = newDate;
                                },
                                mode: CupertinoDatePickerMode.date,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.055,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(label),
                      Icon(CupertinoIcons.calendar),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                        color: CupertinoColors.systemBackground,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CupertinoButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoButton(
                                  child: Text(
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
                              child: CupertinoDatePicker(
                                initialDateTime: selectedTime,
                                onDateTimeChanged: (DateTime newTime) {
                                  tempSelectedTime = newTime;
                                },
                                mode: CupertinoDatePickerMode.time,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.055,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(label1),
                      Icon(CupertinoIcons.time),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLabel("Ajouter Participant "),
                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.add))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
