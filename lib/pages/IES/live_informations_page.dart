import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/models/live.dart';

class LiveInformationsPage extends StatefulWidget {
  const LiveInformationsPage({super.key});

  @override
  State<LiveInformationsPage> createState() => _LiveInformationsPageState();
}

class _LiveInformationsPageState extends State<LiveInformationsPage> {
  double sectionPadding = 0;
  double iconButtonSize = 0;
  double titleFontSize = 0;

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Live live = ModalRoute.of(context)!.settings.arguments as Live;

    final screenWidth = MediaQuery.of(context).size.width;

    iconButtonSize = screenWidth * 0.06;
    sectionPadding = screenWidth * 0.04;
    titleFontSize = screenWidth * 0.06;
    return Scaffold(
      backgroundColor: Color(0xffF5F5F6),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name: "Chaimae Bouti",
              role: "docteur",
              imagePath: 'assets/images/boy.png',
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  padding: EdgeInsets.all(sectionPadding),
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            child: Image.asset(
                              live.liveImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.only(left: 30,right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:screenWidth*0.22,
                                  child: Text(
                                    "Sujet du live :",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                      color: Color(0xFF2E37A4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: sectionPadding*4),
                                Expanded(
                                  child: AutoSizeText(
                                    live.subject,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:screenWidth*0.22,
                                  child: Text(
                                    "Docteur/Infirmier :",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                      color: Color(0xFF2E37A4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: sectionPadding*4),
                                Expanded(
                                  child: Text(
                                    live.doctor.name,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:screenWidth*0.22,
                                  child: Text(
                                    "Date du live :",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                      color: Color(0xFF2E37A4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: sectionPadding*4),
                                Expanded(
                                  child: Text(
                                    "${live.date.day}/${live.date.month}/${live.date.year}",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:screenWidth*0.22,
                                  child: Text(
                                    "Heure du debut du live :",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                      color: Color(0xFF2E37A4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: sectionPadding*4),
                                Expanded(
                                  child: Text(
                                   live.hour.format(context),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:screenWidth*0.22,
                                  child: Text(
                                    "Lien StreamYard :",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                      color: Color(0xFF2E37A4),
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                SizedBox(width: sectionPadding*4),
                                GestureDetector(
                                  onTap: () => _launchUrl(live.liveLink),
                                  child: Text(
                                    live.liveLink,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: titleFontSize - 7,
                                      color: Color(0xFF99EDE9),
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0xFF99EDE9),

                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.left,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
