import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static void setLocale(BuildContext context) async {
    _ProfileState? state = context.findAncestorStateOfType<_ProfileState>();
    state!.initMyInfos();
  }
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> myInfos = {};
  bool isLoading = true;
  bool isDoc=true;
  Future<Map<String, dynamic>> getInfos() async {
    try {
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
    } catch (e) {
      // Handle error
      return {};
    }
  }

  Future<void> initMyInfos() async {
    Map<String, dynamic> infos = await getInfos();
    setState(() {
      myInfos = infos;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initMyInfos();
  }


  Widget buildInfoRow(String label, String value, bool isDarkMode) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Colors.white38 : Colors.black38,
                ),
              ),
            )
          ],
        ),
        Divider(
          color: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: Cardi.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: isDarkMode ? const Color(0xff141218) : Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: isDarkMode ? const Color(0xff141218) : Colors.white,
            title: AutoSizeText(
              appLocalizations!.profile,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.9),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => Settings(
                      callBack: () async {
                        Map<String, dynamic> infos = await getInfos();
                        setState(() {
                          myInfos = infos;
                          isLoading = false;
                        });
                      },
                    )),
                  );
                },
                icon: const Icon(CupertinoIcons.settings, size: 28),
              ),
            ],
          ),
          body: isLoading
              ? const Center(child: CupertinoActivityIndicator())
              : SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: isDarkMode ? Colors.white24 : Colors.black26,
                        child: Icon(Icons.person, color: isDarkMode ? Colors.white : Colors.black, size: 40),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSocialMediaIcon("assets/images/linkdine.png"),
                          const SizedBox(width: 10),
                          buildSocialMediaIcon("assets/images/x.png"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildInfoContainer(
                    context,
                    isDarkMode,
                    [
                      AutoSizeText(
                        appLocalizations.aboutMe,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff0ee58d)
                        ),
                      ),
                      Visibility(
                        visible: isDoc,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: AutoSizeText(
                            myInfos["about"] ?? "n/a",
                            style: GoogleFonts.ubuntu(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      buildInfoRow(appLocalizations.nom, myInfos["nom"] ?? "", isDarkMode),
                      buildInfoRow(appLocalizations.prenom, myInfos["prenom"] ?? "", isDarkMode),
                      Visibility(visible:isDoc,child:  buildInfoRow(appLocalizations.stateDoc.split("?")[0], myInfos["estMedcinESJ"] == null ? "" : myInfos["estMedcinESJ"] ? "oui" : "non", isDarkMode)),
                      Visibility(visible: isDoc,child: buildInfoRow(appLocalizations.speciality, myInfos["specialite"] ?? "", isDarkMode)),
                      buildInfoRow("CIN", myInfos["cin"] ?? "", isDarkMode),
                      buildInfoRow("INPE", myInfos["inpe"] ?? "", isDarkMode),
                      Visibility(visible: isDoc,child: buildInfoRow("ppr", myInfos["ppr"] ?? "", isDarkMode)),
                      buildInfoRow(appLocalizations.email, myInfos["mail"] ?? "", isDarkMode),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildInfoContainer(
                    context,
                    isDarkMode,
                    [
                      AutoSizeText(
                        appLocalizations.education,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff0ee58d),
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildEducationItem("2001-2005", "Université du Wyoming", isDarkMode),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSocialMediaIcon(String assetPath) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(assetPath),
        ),
      ),
    );
  }

  Widget buildInfoContainer(BuildContext context, bool isDarkMode, List<Widget> children) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white24 : const Color(0xfffafffa),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget buildEducationItem(String year, String institution, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  year,
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                const SizedBox(height: 8),
                AutoSizeText(
                  institution,
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
