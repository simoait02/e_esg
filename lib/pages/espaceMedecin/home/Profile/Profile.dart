import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: Cardi.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
          appBar: AppBar(
            backgroundColor: isDarkMode ? const Color(0xff181a1b) : Colors.white,
            title: Container(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                appLocalizations!.profile,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.9),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => const Settings()),
                  );
                },
                icon: const Icon(CupertinoIcons.settings, size: 28),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Cardi.isDarkMode.value ? Colors.white24 : Colors.black26,
                            child: Icon(Icons.person, color: Cardi.isDarkMode.value ? Colors.white : Colors.black, size: 60),
                          ),
                          SizedBox(width: width * 0.02),
                          AutoSizeText(
                            "simo",
                            style: GoogleFonts.aBeeZee(fontSize: 30),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/linkdine.png"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/x.png"),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: width * 0.95,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Cardi.isDarkMode.value ? Colors.white24 : const Color(0xfffafffa),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          appLocalizations.aboutMe,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff0ee58d)
                          ),
                        ),
                        AutoSizeText(
                          "description",
                          style: GoogleFonts.abel(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                appLocalizations.sex,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                appLocalizations.male,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Cardi.isDarkMode.value ? Colors.white38 : Colors.black38,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                appLocalizations.designation,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Medecin senior",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Cardi.isDarkMode.value ? Colors.white38 : Colors.black38,
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                appLocalizations.nom,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Simo",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Cardi.isDarkMode.value ? Colors.white38 : Colors.black38,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                appLocalizations.prenom,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Simo",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Cardi.isDarkMode.value ? Colors.white38 : Colors.black38,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                appLocalizations.tele,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "1234567890",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Cardi.isDarkMode.value ? Colors.white38 : Colors.black38,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: Text(
                                appLocalizations.email,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "qwertyuiop@gmail.com",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Cardi.isDarkMode.value ? Colors.white38 : Colors.black38,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: width * 0.95,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Cardi.isDarkMode.value ? Colors.white24 : const Color(0xfffafffa),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Cardi.isDarkMode.value ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          appLocalizations.education,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff0ee58d)
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
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
                                      "2001-2005",
                                      style: GoogleFonts.roboto(fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    AutoSizeText(
                                      "Université du Wyoming",
                                      style: GoogleFonts.roboto(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
