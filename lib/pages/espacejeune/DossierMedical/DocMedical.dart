import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'docMedical01.dart';
import 'docMedical02.dart';
import 'docMedical03.dart';
import 'docMedical05.dart';

class DocMedical extends StatefulWidget {
  const DocMedical({super.key});
  static void setIndex(BuildContext context, int newIndex) async {
    _DocMedicalState? state = context.findAncestorStateOfType<_DocMedicalState>();
    state!.changeIndex(newIndex);
  }
  static void setProgress(BuildContext context, double newProgress) async {
    _DocMedicalState? state = context.findAncestorStateOfType<_DocMedicalState>();
    state!.changeProgress(newProgress);
  }
  @override
  State<DocMedical> createState() => _DocMedicalState();
}

class _DocMedicalState extends State<DocMedical> {
  List<Widget> widgets=[
    Docmedical01(),
    Docmedical02(),
    Docmedical03(),
    Docmedical05()
  ];
  int index=0;
  void changeIndex(int value){
    setState(() {
      index=value;
    });
  }
  double progress=0.1;

  void changeProgress(double value){
    setState(() {
      progress=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CardiJeune.isDarkMode.value ? const Color(0xff141218) : Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  color: const Color(0xff65558f),
                  backgroundColor: const Color(0xFFEAEBF6),
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(height: height*0.03),
                widgets[index],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
