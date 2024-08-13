import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/bottomModalsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Profile.dart';

class Infospersonal extends StatefulWidget {
  const Infospersonal({super.key});

  @override
  State<Infospersonal> createState() => _InfospersonalState();
}

class _InfospersonalState extends State<Infospersonal> {
  Map<String, dynamic> myInfos = {};
  bool isDoc=true;

  Future<Map<String, dynamic>> getInfos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDoc=prefs.getBool("isDoc")!;
    this.isDoc=isDoc;
    String? token =isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
    int? id =isDoc? prefs.getInt("IdDoc"):prefs.getInt("IdInf");
    final response = await api.get(
      "${isDoc?EndPoints.GetAllMedecins:EndPoints.GetInfermierviaId}/$id",
      headers: {
        "Authorization": "$token",
      },
    );
    return response;
  }

  Future<void> initMyInfos() async {
    Map<String, dynamic> infos = await getInfos();
    setState(() {
      myInfos = infos;
    });
  }

  @override
  void initState() {
    super.initState();
    initMyInfos();
  }
  Color backgroundColor = Cardi.isDarkMode.value ? const Color(0xff181a1b) : Colors.white;
  Color textColor = Cardi.isDarkMode.value ? Colors.white : Colors.black;



  Widget BuildWidgets(double height, double width, String label, String hint, String image, bool editable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: AutoSizeText(
            label,
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          width: width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  hint,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.aBeeZee(
                    color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                    fontSize: 15,
                  ),
                ),
              ),
              if (editable)
                Container(
                  height: 25, // Scaled based on the passed height
                  width: 25, // Scaled based on the passed height
                  padding: EdgeInsets.all(2),
                  child: Image.asset(
                    "assets/images/$image.png",
                    color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5),
                  ),
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05,),
            Visibility(
              visible: isDoc,
              child: GestureDetector(
                  onTap: () {
                    showBarModalBottomSheet(
                        context: context, builder: (BuildContext context) {
                      return Bottommodalsheet(
                        height: height * 0.5,
                        isDarkMode: Cardi.isDarkMode.value,
                        width: width,
                        parametre: "about",
                        updateInfo: (value) async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          bool isDoc=prefs.getBool("isDoc")!;
                          String? token =isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
                          int? id =isDoc? prefs.getInt("IdDoc"):prefs.getInt("IdInf");
                          await api.patch("${isDoc?EndPoints.GetAllMedecins:EndPoints.GetInfermierviaId}/$id",
                            data:{
                              "about":value
                            },
                            headers: {
                              "Authorization": "$token",
                            },);
                          initMyInfos();
                          Profile.setLocale(context);
                        },
                      );
                    });
                  },
                  child: BuildWidgets(height, width, appLocalizations.aboutMe, myInfos["about"]??"", "edit", true)),
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
                      parametre: "Nom",
                      updateInfo: (value) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        bool isDoc=prefs.getBool("isDoc")!;
                        String? token =isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
                        int? id =isDoc? prefs.getInt("IdDoc"):prefs.getInt("IdInf");
                        await api.patch("${isDoc?EndPoints.GetAllMedecins:EndPoints.GetInfermierviaId}/$id",
                          data:{
                          "nom":value
                          },
                          headers: {
                            "Authorization": "$token",
                          },);
                        initMyInfos();
                        Profile.setLocale(context);
                      },
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.nom, myInfos["nom"]??"", "edit", true)),
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
                      updateInfo: (value) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        bool isDoc=prefs.getBool("isDoc")!;
                        String? token =isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
                        int? id =isDoc? prefs.getInt("IdDoc"):prefs.getInt("IdInf");
                        await api.patch("${isDoc?EndPoints.GetAllMedecins:EndPoints.GetInfermierviaId}/$id",
                          data:{
                            "prenom":value
                          },
                          headers: {
                            "Authorization": "$token",
                          },);
                        initMyInfos();
                        Profile.setLocale(context);
                      },
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.prenom, myInfos["prenom"]??"", "edit", true)),
            SizedBox(height: height * 0.02,),
            BuildWidgets(height, width, "CIN", myInfos["cin"]??"", "edit", false),
            SizedBox(height: height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BuildWidgets(height, width, "INPE", myInfos["inpe"] ?? "", "edit", false),
                ),
                if (isDoc)
                  SizedBox(width: width * 0.04),
                if (isDoc)
                  Flexible(
                    child: BuildWidgets(height, width, "PPR", myInfos["ppr"] ?? "", "edit", false),
                  ),
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
                      updateInfo: (value) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        bool isDoc=prefs.getBool("isDoc")!;
                        String? token =isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
                        int? id =isDoc? prefs.getInt("IdDoc"):prefs.getInt("IdInf");
                        await api.patch("${isDoc?EndPoints.GetAllMedecins:EndPoints.GetInfermierviaId}/$id",
                          data:{
                            "mail":value
                          },
                          headers: {
                            "Authorization": "$token",
                          },);
                        initMyInfos();
                        Profile.setLocale(context);
                      },
                    );
                  });
                },
                child: BuildWidgets(height, width, appLocalizations.email, myInfos["mail"]??"", "edit", true)
            ),
            SizedBox(height: height * 0.02,),
          ],
        ),
      ),
    );
  }
}
