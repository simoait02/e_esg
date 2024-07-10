import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/home/Profile/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: isDarkMode?const Color(0xff181a1b): Colors.white,
        leading: Container(
          alignment: Alignment.centerLeft,
          child: AutoSizeText(
            textAlign: TextAlign.center,
            "mbarkiwi hamoudi",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20,
                color:isDarkMode?Colors.white.withOpacity(0.9):Colors.black.withOpacity(0.9),
              )
            ),
          ),
        ),
        trailing: IconButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context)=>Settings()));
          },
          icon: const Icon(CupertinoIcons.settings,size: 28,),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height*0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                Container(
                  height: height*0.15,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/chocolates-491165_640-640x405.jpg"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Positioned(
                  top: height*0.09,
                  left: width*0.08,
                  child: Container(
                    height: width * 0.22,
                    width: width * 0.22,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: width*0.08,
                      child: Image.asset("assets/images/boy.png"),
                    ),
                  )
                ),
                Positioned(
                  top: height*0.17,
                  left: width*0.35,
                  child: Column(
                    children: [
                      Text("Dr. lionel messi",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        )
                      ),),
                      const Text("Junior Doctor"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: height*0.3,
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText("About me",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 22,
                       color: Color(0xff5085ab)
                    )
                  ),
                ),
                SizedBox(height: height*0.01,),
                Row(
                  children: [
                    SizedBox(
                        width: width * 0.3,
                        child: AutoSizeText(
                          maxLines: 2,
                          "Gender ",
                          style: GoogleFonts.aBeeZee(
                            textStyle:  const TextStyle(fontWeight: FontWeight.w500,fontSize: 17),
                          ),)
                    ),
                    SizedBox(width: width*0.2,),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Male",textAlign: TextAlign.left,
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
                SizedBox(height: height*0.01,),
                Row(
                  children: [
                    SizedBox(
                        width: width * 0.3,
                        child: AutoSizeText(
                          maxLines: 2,
                          "Designation",
                          style: GoogleFonts.aBeeZee(
                            textStyle:  const TextStyle(fontWeight: FontWeight.w500,fontSize: 17),
                          ),)
                    ),
                    SizedBox(width: width*0.2,),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Sr. Doctor",textAlign: TextAlign.left,
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
                SizedBox(height: height*0.05,),
                AutoSizeText("Speciality",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          color: Color(0xff5085ab)
                      )
                  ),
                ),
                SizedBox(height: height*0.01,),
                AutoSizeText("Médecin au centre d’ESJ",textAlign: TextAlign.left,
                  maxLines: 1,
                  style: GoogleFonts.aBeeZee(
                    textStyle:  TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: isDarkMode? Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5)
                    ),
                  ),
                ),
                SizedBox(height: height*0.01,),
                AutoSizeText("Médecin spécialisé en allergologie",textAlign: TextAlign.left,
                  maxLines: 1,
                  style: GoogleFonts.aBeeZee(
                    textStyle:  TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: isDarkMode? Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5)
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
