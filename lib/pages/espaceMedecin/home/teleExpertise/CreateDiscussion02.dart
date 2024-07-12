import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Creatediscussion02 extends StatefulWidget {
  const Creatediscussion02({super.key});

  @override
  State<Creatediscussion02> createState() => _Creatediscussion02State();
}

class _Creatediscussion02State extends State<Creatediscussion02> {
  String label = "Select meeting date";
  DateTime selectedDateTime = DateTime.now();
  DateTime tempSelectedDateTime = DateTime.now();
  String label1 = "Select meeting time";
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
        SizedBox(height: height*0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Motif de Discussion"),
            SizedBox(
              width: width,
              child: CupertinoTextField(
                style: TextStyle(
                  color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                ),
                minLines: 1,
                maxLines: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Eventuels Traitements"),
            SizedBox(
              width: width,
              child: CupertinoTextField(
                style: TextStyle(
                  color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                ),
                minLines: 1,
                maxLines: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        buildLabel("Importez tout fichier qui serait utile aux autres medecins"),
        Container(
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
              Text("file input"),
              Icon(CupertinoIcons.arrow_down_doc,color:Cardi.isDarkMode.value?CupertinoColors.white.withOpacity(0.5): CupertinoColors.black.withOpacity(0.5),),
            ],
          ),
        ),
        const SizedBox(height: 20),

      ],
    );
  }
}
