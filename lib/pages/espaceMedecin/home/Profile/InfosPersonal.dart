import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/bottomModalsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Infospersonal extends StatefulWidget {
  const Infospersonal({super.key});

  @override
  State<Infospersonal> createState() => _InfospersonalState();
}

class _InfospersonalState extends State<Infospersonal> {
  String nom = "Marquina";
  String prenom = "Sergio";
  String cin = "xxxxxxxx";
  String inpe = "xxxxxxxx";
  String ppr = "xxxxxxxx";
  String email = "sergiomarquina@gmail.com";
  String numtele = "1234567890";

  Color backgroundColor = Cardi.isDarkMode.value ? const Color(0xff181a1b) : Colors.white;
  Color textColor = Cardi.isDarkMode.value ? Colors.white : Colors.black;

  void _updateInfo(String key, String value) {
    setState(() {
      switch (key) {
        case "Nom":
          nom = value;
          break;
        case "Prénom":
          prenom = value;
          break;
        case "email":
          email = value;
          break;
        case "numTele":
          numtele = value;
          break;
        case "password":
          break;
      }
    });
  }

  Widget BuildWidgets(double height, double width, String label, String hint, String image, bool editable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: AutoSizeText(label, style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
              fontSize: 17,
            ),
          ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height * 0.055,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(hint,
                style: GoogleFonts.aBeeZee(
                  color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                  fontSize: 15,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                padding: EdgeInsets.all(2),
                child: editable ? Image.asset("assets/images/$image.png",
                  color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),) : Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: backgroundColor,
        previousPageTitle: appLocalizations!.precedent,
        middle: Text(
          appLocalizations.myInfos,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05,),
            GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context, builder: (BuildContext context) {
                    return Bottommodalsheet(
                      height: height * 0.5,
                      isDarkMode: Cardi.isDarkMode.value,
                      width: width,
                      parametre: "Nom",
                      updateInfo: _updateInfo,
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.nom, nom, "edit", true)),
            SizedBox(height: height * 0.02,),
            GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context, builder: (BuildContext context) {
                    return Bottommodalsheet(
                      height: height * 0.5,
                      isDarkMode: Cardi.isDarkMode.value,
                      width: width,
                      parametre: "Prénom",
                      updateInfo: _updateInfo,
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.prenom, prenom, "edit", true)),
            SizedBox(height: height * 0.02,),
            BuildWidgets(height, width, "CIN", cin, "edit", false),
            SizedBox(height: height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildWidgets(height, width * 0.4, "INPE", inpe, "edit", false),
                BuildWidgets(height, width * 0.4, "PPR", ppr, "edit", false),
              ],
            ),
            SizedBox(height: height * 0.02,),
            GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context, builder: (BuildContext context) {
                    return Bottommodalsheet(
                      height: height * 0.5,
                      isDarkMode: Cardi.isDarkMode.value,
                      width: width,
                      parametre: "email",
                      updateInfo: _updateInfo,
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.email, email, "edit", true)
            ),
            SizedBox(height: height * 0.02,),
            GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context, builder: (BuildContext context) {
                    return Bottommodalsheet(
                      height: height * 0.5,
                      isDarkMode: Cardi.isDarkMode.value,
                      width: width,
                      parametre: "numTele",
                      updateInfo: _updateInfo,
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.tele, numtele, "edit", true)),
            SizedBox(height: height * 0.02,),
            Divider(
              color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.2),
              thickness: 1,
            ),
            SizedBox(height: height * 0.02,),
            GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context, builder: (BuildContext context) {
                    return Bottommodalsheet(
                      height: height * 0.5,
                      isDarkMode: Cardi.isDarkMode.value,
                      width: width,
                      parametre: "password",
                      updateInfo: _updateInfo,
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.password, "Password", "next", true)),
          ],
        ),
      ),
    );
  }
}
