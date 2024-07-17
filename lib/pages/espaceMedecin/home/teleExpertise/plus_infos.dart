import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlusInfos extends StatefulWidget {
  const PlusInfos({super.key});

  @override
  State<PlusInfos> createState() => _PlusInfosState();
}

class _PlusInfosState extends State<PlusInfos> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
      appBar: CupertinoNavigationBar(
        previousPageTitle: "Back",
        middle: Text("Informations"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: height*0.1,),
            Hero(
              tag: "motif",
              child: Material(
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.28,
                      child: Text(
                        "Motif: ",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Discutons du cas d'un patient souffrant d'une irritation cutanée. Cette discussion abordera les causes potentielles.",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff2e37a4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.28,
                  child: AutoSizeText("Lancée par : ",
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText("simo",
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff2e37a4)
                        )
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.28,
                  child: AutoSizeText("Participants :",
                    maxLines: 1,
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("-simo",
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff2e37a4)
                            )
                        ),
                      ),
                      AutoSizeText("-chaimae",
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff2e37a4)
                            )
                        ),
                      ),
                      AutoSizeText("-yassmine",
                        style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff2e37a4)
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.28,
                  child: AutoSizeText("Date : ",
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText("29/05/2024",
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff2e37a4)
                        )
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.28,
                  child: AutoSizeText("Time : ",
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText("09:30",
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff2e37a4)
                        )
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.28,
                  child: AutoSizeText("Compte Rendue : ",
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: (){},
                  icon: Icon(CupertinoIcons.arrow_down_doc,size: 30,))
                ),
              ],
            ),
          ]
        ),
      )
    );
  }
}
