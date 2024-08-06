import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/plus_infos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../LoginSignUp/Cardi.dart';

class Discussions extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;

  const Discussions({
    super.key,
    required this.isSideBarClosed,
    required this.onSidebarToggle,
  });

  @override
  State<Discussions> createState() => _DiscussionsState();
}

class _DiscussionsState extends State<Discussions> {
  late List invitations;
  late List discussion=[];
  Future<void> getInvitation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenDoc');
    final get=await api.get(EndPoints.GetInvitation,headers:{
      "Authorization":"$token"
    });
    invitations=get;
  }
  Future<void> getDiscussionsViaId() async{
    for(dynamic invitation in invitations){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('tokenDoc');
      print(invitation["id"]);
      final get=await api.get(EndPoints.GetDiscussionViaId+"/${invitation["discussionId"]}",headers:{
        "Authorization":"$token"
      });
      discussion.add(get);
      print(discussion);
    }
  }
  Widget buildSegmentedControlItem(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Cardi.isDarkMode.value ? CupertinoColors.white : CupertinoColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  Future<void> loadData() async {
    await getInvitation();
    await getDiscussionsViaId();
  }
  int typeNoti = 0;

  bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }
  @override
  void initState() {
    loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: true,
          floating: true,
          snap: true,
          backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
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
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                width: width,
                child: CupertinoSlidingSegmentedControl<int>(
                  padding: const EdgeInsets.all(4),
                  groupValue: typeNoti,
                  onValueChanged: (int? value) {
                    setState(() {
                      typeNoti = value!;
                    });
                  },
                  children: {
                    0: buildSegmentedControlItem(appLocalizations!.myInvitations),
                    1: buildSegmentedControlItem(appLocalizations.discTermin),
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              typeNoti == 0
                  ? Container(
                  height: height *0.7, // Set a specific height for the ListView
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      itemCount: discussion.length+1,
                      itemBuilder: (context,index){
                        if(index<discussion.length){
                          final item=discussion[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Cardi.isDarkMode.value ? const Color(0xe5212125) : const Color(0xfffbfbfd),
                              border: Border.all(color: Cardi.isDarkMode.value ? Colors.white24 : Colors.black26),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
                                  title: Text(
                                  (item["medcinResponsable"]["nom"]).toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text((item["medcinResponsable"]["specialite"]).toString()),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      appLocalizations.motif + ":",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        (item["motifDeTeleExpertise"]).toString(),
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
                                const SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      appLocalizations.date + ":",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        DateFormat('yyyy-MM-dd').format(DateTime.parse(item["date"])),
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff21c6b7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      appLocalizations.time + ":",
                                      style: GoogleFonts.aBeeZee(
                                        textStyle: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        (item["heure"]),
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff21c6b7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoButton(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.red),
                                        ),
                                        child: AutoSizeText(
                                          appLocalizations.refuser,
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {}
                                      ,
                                    ),
                                    CupertinoButton(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: height * 0.05,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: AutoSizeText(
                                          appLocalizations.accepter,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      })
              )
                  : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => PlusInfos()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    color: Cardi.isDarkMode.value ? const Color(0xe5212125) : const Color(0xfffbfbfd),
                    border: Border.all(color: Cardi.isDarkMode.value ? Colors.white24 : Colors.black26),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'simo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Cardi.isDarkMode.value ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Chirurgien',
                              style: TextStyle(
                                color: Cardi.isDarkMode.value ? Colors.white60 : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(CupertinoIcons.chevron_right),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}