import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dossiermedical extends StatefulWidget {
  const Dossiermedical({super.key});

  @override
  State<Dossiermedical> createState() => DossiermedicalState();
}

class DossiermedicalState extends State<Dossiermedical> {
  int selectedIndex = 0;

  final Map<String, String> infos = {
    "Nom": "Marquina",
    "Prénom": "Sergio",
    "Sexe": "Masculin",
    "Né le": "20/07/2000",
    "E-mail": "sergiomarquina@gmail.com",
    "Telephone": "0685123456",
    "Scolarité": "Non",
    "CIN": "XD465264",
    "Antécédants Médicaux":
        "De 10/07/2023 a 24/07/2024 \n -hépatique \n -fievre",
    "Antécédants Chirurgicaux": "Oui",
    "Antécédants familiaux": "tttt",
  };


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:isDarkMode?Color(0xff141218):Colors.white,
      body:  SafeArea(
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 1,
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Changer la photo de profil');
                          },
                          child: CircleAvatar(
                            radius: screenWidth * 0.15,
                            backgroundImage:
                                AssetImage('assets/images/boy.png'),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: infos.length,
                          separatorBuilder: (context, index) => Divider(
                            color: isDarkMode? Color(0xff545456):Color(0x56545456),
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            String key = infos.keys.elementAt(index);
                            String value = infos[key]!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenWidth * 0.3,
                                    child: AutoSizeText(
                                      maxLines: 2,
                                      "$key ",
                                      style: GoogleFonts.aBeeZee(
                                          textStyle:  TextStyle(fontWeight: FontWeight.w500,fontSize: 17),
                                    ),)
                                  ),
                                  SizedBox(width: screenWidth*0.05,),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(value,textAlign: TextAlign.left,
                                      style: GoogleFonts.aBeeZee(
                                        textStyle:  TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          color: isDarkMode? Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
