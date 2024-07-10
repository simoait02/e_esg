import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool themePressed=false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: isDarkMode ? Color(0xff181a1b) : Colors.white,
        previousPageTitle: "Back",
        middle: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FluentIcons.settings_16_regular),
              SizedBox(width: 8),
              Text(
                "Settings",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: GestureDetector(
          onTap: () {},
          child: Text(
            "Done",
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
      ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.05,),
              Row(
                children: [
                  SizedBox(
                    height:35,
                    width: 35,
                    child: Image.asset("assets/images/language.png",color: isDarkMode? Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),),
                  ),
                  SizedBox(width: width*0.02,),
                  AutoSizeText("Language",style: GoogleFonts.aBeeZee(
                    textStyle: const TextStyle(
                      fontSize: 22
                    )
                  ),)
                ],
              ),
              Divider(
                color:isDarkMode?Colors.white.withOpacity(0.2): Colors.black.withOpacity(0.2),
                thickness: 1,
              ),
              Row(
                children: [
                  SizedBox(
                    height:35,
                    width: 35,
                    child: Image.asset("assets/images/theme.png",color: isDarkMode? Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),),
                  ),
                  SizedBox(width: width*0.02,),
                  AutoSizeText("Theme",style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          fontSize: 22
                      )
                    ),
                  ),
                  Expanded(
                      child: Align(alignment: AlignmentDirectional.centerEnd,
                          child: IconButton(
                              onPressed: (){
                                setState(() {
                                  themePressed=!themePressed;
                                });
                              },
                              icon: Icon(themePressed? CupertinoIcons.chevron_up:CupertinoIcons.chevron_down,color: isDarkMode? Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5))
                          )
                      )
                  )
                ],
              ),
              themePressed?
                  Container(
                    padding: EdgeInsets.only(left: width*0.1),
                    child: Column(
                      children: [
                        Divider(
                          color:isDarkMode?Colors.white.withOpacity(0.2): Colors.black.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height:35,
                              width: 35,
                              child: Image.asset("assets/images/darkMode.png",color: isDarkMode? Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),),
                            ),
                            SizedBox(width: width*0.02,),
                            AutoSizeText("Dark mode",style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    fontSize: 22
                                )
                            ),)
                          ],
                        ),
                        Divider(
                          color:isDarkMode?Colors.white.withOpacity(0.2): Colors.black.withOpacity(0.2),
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height:35,
                              width: 35,
                              child: Image.asset("assets/images/lightMode.png",color: isDarkMode? Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),),
                            ),
                            SizedBox(width: width*0.02,),
                            AutoSizeText("Light mode",style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    fontSize: 22
                                )
                            ),)
                          ],
                        ),
                      ],
                    ),
                  ):Container(),

              Divider(
                color:isDarkMode?Colors.white.withOpacity(0.2): Colors.black.withOpacity(0.2),
                thickness: 1,
              ),
              Row(
                children: [
                  SizedBox(
                    height:35,
                    width: 35,
                    child: Image.asset("assets/images/infos.png",color: isDarkMode? Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),),
                  ),
                  SizedBox(width: width*0.02,),
                  AutoSizeText("Mes informations",style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          fontSize: 22
                      )
                  ),)
                ],
              ),
              Divider(
                color:isDarkMode?Colors.white.withOpacity(0.2): Colors.black.withOpacity(0.2),
                thickness: 1,
              ),
              Row(
                children: [
                  SizedBox(
                    height:35,
                    width: 35,
                    child: Image.asset("assets/images/logOut.png",color: isDarkMode? Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),),
                  ),
                  SizedBox(width: width*0.02,),
                  AutoSizeText("Log out",style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          fontSize: 22
                      )
                  ),)
                ],
              ),
            ],
          ),
        ),
    );
  }
}
