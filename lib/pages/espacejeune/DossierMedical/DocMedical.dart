import 'package:e_esg/pages/espacejeune/DossierMedical/docMedical03.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'docMedical01.dart';
import 'docMedical02.dart';

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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDarkMode ? Color(0xff141218) : Colors.white,
        appBar: AppBar(
          backgroundColor: isDarkMode ? Color(0xff141318) : Colors.white,
          title: Text(appLocalizations!.docMedical,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff0b40ff)
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  color: const Color(0xff65558f),
                  backgroundColor: const Color(0xff00d3c7),
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
