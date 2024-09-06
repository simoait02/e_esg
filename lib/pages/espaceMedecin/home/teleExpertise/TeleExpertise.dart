import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/Widgets/MesDemandesNotifications.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api/errors/Exceptions.dart';
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
      bool isDoc=prefs.getBool("isDoc")!;
      id =isDoc? prefs.getInt("IdDoc")!:prefs.getInt("IdInf")!;
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
    bool isDoc=prefs.getBool("isDoc")!;
    id =isDoc? prefs.getInt("IdDoc")!:prefs.getInt("IdInf")!;
    String? token =isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
    final response = await api.get(EndPoints.GetInvitation, headers: {
      "Authorization": "$token"
    });

    // Debug print the response

    for (dynamic invitation in response) {
      if (invitation["medecinInvite"]["id"] == id) {
        final get = await api.get(EndPoints.GetDiscussionViaId + "/${invitation["discussionId"]}", headers: {
          "Authorization": "$token"
        });
        if(intl.DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(get["date"]))==date){
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
    bool isDoc=prefs.getBool("isDoc")!;
    id =isDoc? prefs.getInt("IdDoc")!:prefs.getInt("IdInf")!;
    String? token =isDoc? prefs.getString('tokenDoc'):prefs.getString('tokenInf');
    final response = await api.get(EndPoints.GetAllDiscussion, headers: {
      "Authorization": "$token"
    });

    // Debug print the response

    for (dynamic discussion in response) {
      // Ensure comparison is between same types
      if (discussion["medcinResponsable"]["id"] == id) {
        if(intl.DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(discussion["date"]))==date){
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
                                    fontSize: 20,
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
                          width: width * 0.38,
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
                  height: 220,
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
                    : Directionality(
                      textDirection:Localizations.localeOf(context).languageCode == "ar"? TextDirection.rtl:TextDirection.ltr,
                      child: SizedBox(
                          height: 220,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: myDiscussions.length,
                              itemBuilder: (context, index) {
                                final item = myDiscussions[index];
                                bool condition=DateTime.now().isAfter(
                                    DateTime(DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        int.parse( item["heure"]!.split(':')[0]),
                                        int.parse(item["heure"]!.split(':')[1]))) && DateTime(DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    int.parse( item["heure"]!.split(':')[0]),
                                    int.parse(item["heure"]!.split(':')[1])+30).isAfter(DateTime.now())
                                    && DateTime.fromMillisecondsSinceEpoch(item["date"])==DateTime.now();
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
                                      Container(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "status",
                                                style: GoogleFonts.aBeeZee(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Text(item["status"])),
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
                                                color:  condition
                                                    ? const Color(0xff2e37a4):CupertinoColors.inactiveGray,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Text(
                                              appLocalizations.start,
                                              style: GoogleFonts.aBeeZee(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if(condition){
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              String? token = prefs.getString('tokenDoc');
                                              try{
                                                await api.put(EndPoints.GetDiscussionViaId+("/${item["id"]}/start"), headers: {
                                                  "Authorization": "$token"
                                                });
                                              }on ServerException catch(e){
                                                Fluttertoast.showToast(msg: e.errormodel.errorMsg.toString());
                                              }
                                            }
                                          }),
                                    ],
                                  ),
                                );
                              },
                          ),
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
                  height: 220,
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
                    : Directionality(
                      textDirection:Localizations.localeOf(context).languageCode == "ar"? TextDirection.rtl:TextDirection.ltr,
                      child: SizedBox(
                        height: 220,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: myInvitedDiscussions.length,
                            itemBuilder: (context, index) {
                              final item = myInvitedDiscussions[index];
                              bool Condition= DateTime.now().isAfter(
                                  DateTime(DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      int.parse( item["heure"]!.split(':')[0]),
                                      int.parse(item["heure"]!.split(':')[1]))) && DateTime(DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  int.parse( item["heure"]!.split(':')[0]),
                                  int.parse(item["heure"]!.split(':')[1])+30).isAfter(DateTime.now())
                                  && DateTime.fromMillisecondsSinceEpoch(item["date"])==DateTime.now();
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
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "status",
                                              style: GoogleFonts.aBeeZee(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Text(item["status"])),
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
                                              color: Condition
                                                  ? const Color(0xff2e37a4):CupertinoColors.inactiveGray,
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          child: Text(
                                            appLocalizations.rejoindre,
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if(Condition){
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            String? token = prefs.getString('tokenDoc');
                                            try{
                                              await api.post(EndPoints.GetDiscussionViaId+("/${item["id"]}/join"), headers: {
                                                "Authorization": "$token"
                                              });
                                            }on ServerException catch(e){
                                              Fluttertoast.showToast(msg: e.errormodel.errorMsg.toString());
                                            }
                                          }
                                        }
                                    ),
                                  ],
                                ),
                              );
                            },
                        ),
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