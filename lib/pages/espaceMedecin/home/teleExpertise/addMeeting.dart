import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion01.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion02.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion03.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/CreateDiscussion04.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddMeeting extends StatefulWidget {
  static setIndex(BuildContext context,int index){
    _AddMeetingState? state = context.findAncestorStateOfType<_AddMeetingState>();
    state!.setIndex(index);
  }
  static setProgress(BuildContext context,double progress){
    _AddMeetingState? state = context.findAncestorStateOfType<_AddMeetingState>();
    state!.setProgress(progress);
  }
  const AddMeeting({Key? key}) : super(key: key);

  @override
  State<AddMeeting> createState() => _AddMeetingState();
}

class _AddMeetingState extends State<AddMeeting> {
  bool isChecked = false;
  int index = 0;
  double progress = 0.25;
  void setProgress(double newProgress){
    setState(() {
      progress=newProgress;
    });
  }
  void setIndex(int index){
    setState(() {
      this.index=index;
    });
  }
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
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Cardi.isDarkMode.value?const Color(0xff141218):Colors.white,
      appBar: CupertinoNavigationBar(
        backgroundColor: Cardi.isDarkMode.value ? const Color(0xff181a1b) : Colors.white,
        previousPageTitle: appLocalizations!.precedent,
        middle: Text(
          appLocalizations.createDiscussion,
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
            ],
          ),
        ),
      ),
    );
  }
}
