import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              child: ListTile(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(CupertinoIcons.chevron_back),
                ),
                title: AutoSizeText(
                  "Chat",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff2E37A4),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              height: height * 0.8,
              width: width,
              decoration: const BoxDecoration(
                color: Color(0x1a2e37a4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.05),
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => const Message(
                          name:{
                            "tag":"name",
                            "widget":"Doctor Il Dottore"
                          } ,
                          profile:{
                            "tag":"profile",
                            "widget":const CircleAvatar(
                              radius: 25,
                              child: Icon(
                                CupertinoIcons.person,
                                size: 40,
                              ),
                            )
                          },
                          speciality:{
                            "tag":"subName",
                            "widget":"Specialite"
                          }  ,)),
                      );
                    },
                    child: ListTile(
                      leading: const Hero(
                        tag: "profile",
                        child: CircleAvatar(
                          radius: 25,
                          child: Icon(
                            CupertinoIcons.person,
                            size: 40,
                          ),
                        ),
                      ),
                      title: Hero(
                        tag: "name",
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            "Doctor Il Dottore",
                            style: GoogleFonts.aBeeZee(),
                          ),
                        ),
                      ),
                      subtitle: Hero(
                        tag: "subName",
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            "Specialite",
                            style: GoogleFonts.abel(
                              color: Cardi.isDarkMode.value
                                  ? CupertinoColors.white.withOpacity(0.5)
                                  : CupertinoColors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      trailing: const Icon(CupertinoIcons.forward),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
