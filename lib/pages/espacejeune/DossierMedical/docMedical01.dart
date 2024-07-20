import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espacejeune/DossierMedical/DocMedical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

class Docmedical01 extends StatefulWidget {
  const Docmedical01({super.key});

  @override
  State<Docmedical01> createState() => _Docmedical01State();
}

class _Docmedical01State extends State<Docmedical01> {
  File? _selectedImage;
  bool isSelectedImage = false;

  Future<void> addImage() async {
    final imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker == null) return;
    setState(() {
      _selectedImage = File(imagePicker.path);
      isSelectedImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CircleAvatar(
            radius: 70,
            backgroundImage: isSelectedImage ? FileImage(_selectedImage!) : null,
            child: isSelectedImage ? null : Icon(CupertinoIcons.person, size: 70,),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: addImage,
            child: AutoSizeText(
              appLocalizations!.addImage,
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: const Color(0xff00d3c7),
              ),
            ),
          ),
        ),
        SizedBox(height: height * 0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoRow(width, appLocalizations.nom, "simo", isDarkMode),
            SizedBox(height: height * 0.02),
            buildInfoRow(width, appLocalizations.prenom, "simo", isDarkMode),
            SizedBox(height: height * 0.02),
            buildInfoRow(width, appLocalizations.sex, appLocalizations.male, isDarkMode),
            SizedBox(height: height * 0.02),
            buildInfoRow(width, appLocalizations.birthDay, "dd/mm/yyyy", isDarkMode),
            SizedBox(height: height * 0.02),
            buildInfoRow(width, "CIN", "xxxxxxxx", isDarkMode),
            SizedBox(height: height * 0.02),
            buildInfoRow(width, appLocalizations.email, "xxxxxxxxxxxx@exemple.com", isDarkMode),
            SizedBox(height: height * 0.02),
            buildInfoRow(width, appLocalizations.tele, "1234567890", isDarkMode),
            SizedBox(height: height * 0.02),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: CupertinoButton(
            child: Container(
              width: width * 0.3,
              height: height * 0.05,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff4E57CD), Color(0xff2F38A5)],
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              alignment: Alignment.center,
              child: AutoSizeText(
                appLocalizations.suivant,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            onPressed: () {
              if(isSelectedImage){
                DocMedical.setIndex(context, 1);
                DocMedical.setProgress(context, 0.25);
              }else(
                Fluttertoast.showToast(
                  msg: appLocalizations.addImage,
                  backgroundColor: Colors.red
                )
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(double width, String label, String value, bool isDarkMode) {
    return Row(
      children: [
        Container(
          width: width * 0.3,
          child: AutoSizeText(
            label,
            style: GoogleFonts.aBeeZee(
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: AutoSizeText(
            value,
            style: GoogleFonts.aBeeZee(
              color: isDarkMode ? Colors.white70 : Colors.black54,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
