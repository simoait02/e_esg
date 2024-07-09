import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/addMeeting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TeleExpertise extends StatefulWidget {
  const TeleExpertise({super.key});

  @override
  State<TeleExpertise> createState() => _TeleexpertiseState();
}

class _TeleexpertiseState extends State<TeleExpertise> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(role: "Medcin", name: "simo", imagePath: "assets/images/boy.png"),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:EdgeInsets.only(left: 10),
                    padding: EdgeInsets.only(left:10,top: 10,bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat.yMMMMd().format(DateTime.now()),
                            style: GoogleFonts.aBeeZee(
                              textStyle:  TextStyle(
                                fontSize: 24,
                                color:isDarkMode? const Color(0x9395a6ce): const Color(0x5e0e1462),
                                fontWeight: FontWeight.w500
                              )
                            ),
                            ),
                            Text("Today",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: const TextStyle(
                                      fontSize: 24,
                                    fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                          ],
                        ),
                        CupertinoButton(
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xff2e37a4),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Text(
                                "Créer une discussion",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddMeeting()));
                            })
                      ],
                    ),
                  ),
                  DatePicker(
                    DateTime.now(),
                    height: 123,
                    width: 105,
                    calendarType:CalendarType.gregorianDate,
                    initialSelectedDate: DateTime.now(),
                    selectedTextColor: Colors.white,
                    selectionColor: const Color(0xff2e37a4),
                    dateTextStyle: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        fontSize: 36,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    monthTextStyle:const TextStyle(
                      fontSize: 12,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    dayTextStyle: const TextStyle(
                      fontSize: 12,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    deactivatedColor: Color(0xff505176),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("Mes discussion",
                      style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: width,
                    height: 160,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color:!isDarkMode?CupertinoColors.black.withOpacity(0.5): CupertinoColors.white.withOpacity(0.5),),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text("pas de discussion ce jour-là",
                      style: GoogleFonts.poppins(
                      textStyle:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:isDarkMode?Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5),
                      ),)
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("Télé-Expertise",
                      style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: width,
                    height: 160,
                    decoration: BoxDecoration(
                        border: Border.all(color:!isDarkMode?CupertinoColors.black.withOpacity(0.5): CupertinoColors.white.withOpacity(0.5),),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("assets/images/profiletele.png"),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text("Dr. Mbarki Hamoudi",
                                    style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ),
                                  Text("Chirurgien specialise",
                                    style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                            fontSize: 12,
                                            color:isDarkMode?Color(0x9395a6ce): Color(0x96333541),
                                        )
                                    ),
                                  ),
                                  Text("Maladie",
                                    style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF4254F4),
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Commencer à:",
                                      style: GoogleFonts.rubik(
                                          textStyle: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF4254F4),
                                          )
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text("11:00",
                                            style: GoogleFonts.rubik(
                                                textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: isDarkMode?Color(0x9395a6ce):Color(0x96333541),
                                                  fontWeight: FontWeight.bold
                                                )
                                            ),
                                          ),
                                        ),
                                        Text("  Aujourd’hui",
                                          style: GoogleFonts.rubik(
                                              textStyle: TextStyle(
                                                fontSize: 12,
                                                color: isDarkMode?Color(0x9395a6ce):Color(0x96333541),
                                              )
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              CupertinoButton(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xff2e37a4),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                      child: Text(
                                        "Regoindre",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                  ),
                                  onPressed: (){})
                            ],
                          ),
                        ),

                      ],
                    )
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
