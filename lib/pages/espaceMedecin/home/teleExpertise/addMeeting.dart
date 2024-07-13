import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion01.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion02.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion03.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion04.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMeeting extends StatefulWidget {
  const AddMeeting({Key? key}) : super(key: key);

  @override
  State<AddMeeting> createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  bool isChecked = false;
  int index = 0;
  double progress = 0.25;

  void updateInfo(bool value) {
    setState(() {
      isChecked = value;
    });
  }

  List<Widget> get list => [
    Creatediscussion(),
    Creatediscussion02(),
    Creatediscussion03(),
    Creatediscussion04(isChecked: isChecked, updateInfo: updateInfo),
  ];

  @override
  void dispose() {
    isChecked = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CupertinoNavigationBar(
        backgroundColor: Cardi.isDarkMode.value ? Color(0xff181a1b) : Colors.white,
        previousPageTitle: "Back",
        middle: Text(
          'Create Discussion',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                color: const Color(0xff65558f),
                backgroundColor: const Color(0xff00d3c7),
                borderRadius: BorderRadius.circular(10),
              ),
              list[index],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  index != 0
                      ? CupertinoButton(
                    child: Container(
                      width: width * 0.3,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff0b40ff)),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "Precedent",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (index > 0) {
                          index--;
                          progress -= 0.25;
                        }
                      });
                    },
                  )
                      : Container(),
                  CupertinoButton(
                    child: Container(
                      width: width * 0.3,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: !isChecked && index==3
                            ? LinearGradient(colors: [Color(0xff7a7a7f),Color(0xff696969)])
                            : const LinearGradient(
                          colors: [Color(0xff0b40ff), Color(0xff0c40a4)],
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        index == 3 ? "Valider" : "Suivant",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        if (index == 3 && isChecked) {
                          Navigator.pop(context);
                        }
                        if (index < 3) {
                          index++;
                          progress += 0.25;
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
