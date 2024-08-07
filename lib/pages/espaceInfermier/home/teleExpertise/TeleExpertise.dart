import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:e_esg/pages/espaceInfermier/LoginSignUp/Cardi.dart';
import 'package:e_esg/Widgets/MesDemandesNotifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'addMeeting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TeleExpertise extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;

  const TeleExpertise({
    Key? key,
    required this.isSideBarClosed,
    required this.onSidebarToggle,
  }) : super(key: key);

  @override
  State<TeleExpertise> createState() => _TeleExpertiseState();
}

class _TeleExpertiseState extends State<TeleExpertise> {
  bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }
  String language='en';
  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }
  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = prefs.getString("language") ?? 'en';
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading:true,
            floating: true,
            snap: true,
            backgroundColor: CardiInf.isDarkMode.value ? const Color(0xff141218) : Colors.white,
            leading: Container(
              alignment: Alignment.center,
              height: 40,
              width: 40,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: widget.onSidebarToggle,
                child: widget.isSideBarClosed
                    ? SvgPicture.asset('assets/images/more.svg')
                    : Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                      color: Color(0x5e0e1462),
                      shape: BoxShape.circle),
                  child: const Icon(CupertinoIcons.clear, color: Color(0xff2e37a4)),
                ),
              ),
            ),
            actions: [
              Hero(
                tag: "notification",
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => MesDemandesNotifications()));
                  },
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset('assets/images/note_icon.svg'),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Container(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      'assets/images/messages.svg',
                      color: const Color(0xff2e37a4),
                    )),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            intl.DateFormat.yMMMMd().format(DateTime.now()),
                            style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                    fontSize: 24,
                                    color: CardiInf.isDarkMode.value
                                        ? const Color(0x9395a6ce)
                                        : const Color(0x5e0e1462),
                                    fontWeight: FontWeight.w500)),
                          ),
                          Text(
                            appLocalizations!.today,
                            style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      CupertinoButton(
                          child: Container(
                            height: 40,
                            width: width * 0.4,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xff2e37a4),
                                borderRadius: BorderRadius.circular(10)),
                            child: AutoSizeText(
                              appLocalizations.createDiscussion,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const AddMeeting()
                                )
                            );
                          }
                        )
                    ],
                  ),
                ),
                DatePicker(
                  locale: language,
                  DateTime.now(),
                  height: 123,
                  width: 105,
                  onDateChange: (value) {
                    print(value);
                  },
                  calendarType: CalendarType.gregorianDate,
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
                  monthTextStyle: const TextStyle(
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
                  deactivatedColor: const Color(0xff505176),
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment:language=='ar'?Alignment.centerRight:Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(appLocalizations.myCreatedDiscussion,
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                            fontSize: 20,
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
                      border: Border.all(color:!CardiInf.isDarkMode.value?CupertinoColors.black.withOpacity(0.5): CupertinoColors.white.withOpacity(0.5),),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(appLocalizations.emptyDisc,
                      style: GoogleFonts.poppins(
                        textStyle:  TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color:CardiInf.isDarkMode.value?Colors.white.withOpacity(0.5): Colors.black.withOpacity(0.5),
                        ),)
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment:language=='ar'?Alignment.centerRight:Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(appLocalizations.myInviteddDiscussion,
                    style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                            fontSize: 20,
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
                        border: Border.all(color:!CardiInf.isDarkMode.value?CupertinoColors.black.withOpacity(0.5): CupertinoColors.white.withOpacity(0.5),),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(5),
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
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ),
                                  Text("Chirurgien specialise",
                                    style: GoogleFonts.rubik(
                                        textStyle: TextStyle(
                                          fontSize: 12,
                                          color:CardiInf.isDarkMode.value?const Color(0x9395a6ce): const Color(0x96333541),
                                        )
                                    ),
                                  ),
                                  Text("Maladie",
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
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
                                  Directionality(
                                    textDirection: isArabic(context)?TextDirection.rtl:TextDirection.ltr,
                                    child: Text(appLocalizations.startAt,
                                      style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF4254F4),
                                          )
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text("11:00",
                                          style: GoogleFonts.rubik(
                                              textStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: CardiInf.isDarkMode.value?const Color(0x9395a6ce):const Color(0x96333541),
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                        ),
                                      ),
                                      Text(appLocalizations.today,
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              color: CardiInf.isDarkMode.value?const Color(0x9395a6ce):const Color(0x96333541),
                                            )
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              CupertinoButton(
                                  child: Container(
                                    width: width*0.4,
                                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff2e37a4),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(
                                      appLocalizations.rejoindre,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                  onPressed: (){}
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ],
            )
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: height*0.1,),
          )
        ],
      ),
    );
  }
}