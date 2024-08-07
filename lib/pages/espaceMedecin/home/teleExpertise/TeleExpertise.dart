import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/pages/espaceInfermier/home/teleExpertise/discussions.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/Widgets/MesDemandesNotifications.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/chat.dart';
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

  String language = 'en';
  int id = 0;
  late List myDiscussions = [];
  late List myInvitedDiscussions = [];
  @override
  void initState() {
    super.initState();
    _loadPreferences();
    loadData();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = prefs.getString("language") ?? 'en';
      id = prefs.getInt("IdDoc")!;
    });
  }

  Future<void> loadData() async {
    List discussions = await GetDiscussion(selctedDate);
    List invitedDiscussions=await getInvitedDiscussion(selctedDate);
    setState(() {
      myDiscussions = discussions;
      myInvitedDiscussions=invitedDiscussions;
    });
  }


  Future<List> getInvitedDiscussion(String date) async {
    List discussions = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("IdDoc")!;
    String? token = prefs.getString('tokenDoc');
    final response = await api.get(EndPoints.GetInvitation, headers: {
      "Authorization": "$token"
    });

    // Debug print the response
    print("getInvitedDiscussion response: $response");

    for (dynamic invitation in response) {
      print("***********************************************************************************************************");
      print(invitation["medecinInvite"]["id"]);
      if (invitation["medecinInvite"]["id"] == id) {
        final get = await api.get(EndPoints.GetDiscussionViaId + "/${invitation["discussionId"]}", headers: {
          "Authorization": "$token"
        });
        if(intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(get["date"]))==date){
          print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
          print(get);
          discussions.add(get);
        }
      }
    }
    return discussions;
  }
//intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(item["date"]))
  Future<List> GetDiscussion(String date) async {
    List discussions = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("IdDoc")!;
    String? token = prefs.getString('tokenDoc');
    final response = await api.get(EndPoints.GetAllDiscussion, headers: {
      "Authorization": "$token"
    });

    // Debug print the response
    print("GetDiscussion response: $response");

    for (dynamic discussion in response) {
      // Ensure comparison is between same types
      if (discussion["medcinResponsable"]["id"] == id) {
        if(intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(discussion["date"]))==date){
          discussions.add(discussion);
        }
      }
    }
    return discussions;
  }
  String selctedDate=intl.DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
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
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: true,
            floating: true,
            snap: true,
            backgroundColor: Cardi.isDarkMode.value
                ? const Color(0xff141218)
                : Colors.white,
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
                      color: Color(0x5e0e1462), shape: BoxShape.circle),
                  child: const Icon(CupertinoIcons.clear,
                      color: Color(0xff2e37a4)),
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
                            builder: (context) =>
                                MesDemandesNotifications()
                        )
                    );
                  },
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset('assets/images/note_icon.svg'),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context, CupertinoPageRoute(builder: (context) => const Chat()));
                },
                icon: SizedBox(
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
                                    color: Cardi.isDarkMode.value
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
                            style: const TextStyle(
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
                                  builder: (context) => const AddMeeting()));
                        },
                      ),
                    ],
                  ),
                ),
                DatePicker(
                  locale: language,
                  DateTime.now(),
                  height: 123,
                  width: 105,
                  onDateChange: (value) {
                    setState(() {
                      selctedDate=intl.DateFormat('yyyy-MM-dd').format(value).toString();
                    });
                    loadData();
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
                  alignment: language == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    appLocalizations.myCreatedDiscussion,
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                myDiscussions.isEmpty
                    ? Container(
                  width: width,
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Cardi.isDarkMode.value?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          appLocalizations.emptyDisc,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Cardi.isDarkMode.value
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                    )
                    : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: myDiscussions.length,
                    itemBuilder: (context, index) {
                      final item = myDiscussions[index];
                      return Container(
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: Cardi.isDarkMode.value?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                              title: Text(
                                item["medcinResponsable"]["nom"] +
                                    " " +
                                    item["medcinResponsable"]["prenom"],
                                style: GoogleFonts.aBeeZee(),
                              ),
                              subtitle: Text(
                                item["medcinResponsable"]["specialite"],
                                style: GoogleFonts.abel(),
                              ),
                            ),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "${appLocalizations.motifDiscussion}:",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          item["motifDeTeleExpertise"])),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      appLocalizations.startAt,
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(item["heure"])),
                                ],
                              ),
                            ),
                            CupertinoButton(
                                child: Container(
                                  width: width,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff2e37a4),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Text(
                                    appLocalizations.start,
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment: language == 'ar' ? Alignment.centerRight : Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    appLocalizations.myInviteddDiscussion,
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                myInvitedDiscussions.isEmpty
                    ? Container(
                  width: width,
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Cardi.isDarkMode.value?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    appLocalizations.emptyDisc,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Cardi.isDarkMode.value
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                )
                    : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: myInvitedDiscussions.length,
                    itemBuilder: (context, index) {
                      final item = myInvitedDiscussions[index];
                      return Container(
                        width: width * 0.8,
                        decoration: BoxDecoration(
                            border: Border.all(color: Cardi.isDarkMode.value?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                              title: Text(
                                item["medcinResponsable"]["nom"] +
                                    " " +
                                    item["medcinResponsable"]["prenom"],
                                style: GoogleFonts.aBeeZee(),
                              ),
                              subtitle: Text(
                                item["medcinResponsable"]["specialite"],
                                style: GoogleFonts.abel(),
                              ),
                            ),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "${appLocalizations.motifDiscussion}:",
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          item["motifDeTeleExpertise"])),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      appLocalizations.startAt,
                                      style: GoogleFonts.aBeeZee(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(item["heure"])),
                                ],
                              ),
                            ),
                            CupertinoButton(
                                child: Container(
                                  width: width,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff2e37a4),
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Text(
                                    appLocalizations.rejoindre,
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white),
                                  ),
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: height * 0.1,),
          ),
        ],
      ),
    );
  }
}
