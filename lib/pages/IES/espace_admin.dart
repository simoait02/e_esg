import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/IES/lives.dart';
import 'package:e_esg/pages/IES/statistiques.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marqueer/marqueer.dart';
import '../../Data/live_list.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import '../../models/live.dart';
import 'ajoutLive.dart';
import 'live_informations_page.dart';

class EspaceAdmin extends StatefulWidget {
  const EspaceAdmin({super.key});

  @override
  State<EspaceAdmin> createState() => _EspaceAdminState();
}

class _EspaceAdminState extends State<EspaceAdmin> {
  double sectionPadding=0;
  double titleFontSize =0;
  double iconFontSize =0;


  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    sectionPadding = screenWidth*0.04;
    titleFontSize = screenWidth*0.035;
    iconFontSize = screenWidth*0.055;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xff141218) : Color(0xffF5F5F6),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
                name: "Liam Michael",
                role: "Admin",
                imagePath: 'assets/images/boy.png'),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 40,
                    color: Colors.red,
                    child: Marqueer(child: AutoSizeText('Nous somme actuellement en direct! Cliquer ici pour accéder à la session et participer.', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: titleFontSize+5))),
                  ),
                  Container(
                    padding: EdgeInsets.all(sectionPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Ajoutlive()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF2E37A4),
                            padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              AutoSizeText(
                                "Plannfier un live",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: titleFontSize , // Safe handling
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.add, color: Colors.white, size: iconFontSize),

                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Lives()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF2E37A4),
                            padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              AutoSizeText(
                                "Voir les lives précédents",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: titleFontSize ,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.video_camera_back, color: Colors.white, size: iconFontSize),


                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Lives planifiés pour 2024/2025",
                          style: TextStyle(
                            fontSize: titleFontSize+7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 290,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: thisWeekLives.length,
                            itemBuilder: (context, index) {
                              return liveComponent(live: thisWeekLives[index], context: context);
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Actualités",
                          style: TextStyle(
                            fontSize: titleFontSize+7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 270,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:allLives.length,
                            itemBuilder: (context, index1) {
                              return liveComponent2(live: allLives[index1]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget liveComponent({required BuildContext context, required Live live}) {
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveInformationsPage(),
          settings: RouteSettings(arguments: live),
        ),
      ),
      child: Container(
        width: 410,
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            live.subject,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          Container(
                            color: Color(0xff2E37A4),
                            height: 2,
                            width: constraints.maxWidth,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          '${live.date.year}-${live.date.month}-${live.date.day}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff2E37A4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 7),
                        AutoSizeText(
                          live.hour.format(context),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            buildPhaseRow("Phase:", "Avant-Questions des jeunes", width,Colors.red),
            buildPhaseRow("Temps restant dans la phase:", "Avant-Questions des jeunes", width,Colors.black),
            buildPhaseRow("Temps restant pour le live:", "Avant-Questions des jeunes", width,Colors.black),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF2E37A4),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Informer l'intervenant",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: titleFontSize,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.video_camera_back, color: Colors.white, size: 20),

                    ],
                  ),
                ),
                SizedBox(width: 8), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF2E37A4),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        "Supprimer",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: titleFontSize,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: 22,
                        height: 22,
                        child: SvgPicture.asset("assets/images/trash.svg",color: Colors.white,),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPhaseRow(String label, String value, double width,Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            label,
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: AutoSizeText(
              value,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: color),
            ),
          ),
        ],
      ),
    );}
  Widget liveComponent2({required Live live}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveInformationsPage(),
          settings: RouteSettings(arguments: live),
        ),
      ),
      child: Container(
        width: 280,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height:  double.infinity,
                width: double.infinity,
                child: Image.asset(
                  live.liveImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.7),
                ),
                height: 130,
                width: double.infinity,
                child: Wrap(
                  children: [
                    Text(
                      live.subject,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleFontSize + 2,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2E37A4),
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "-Description-Description-Description-Description-Description-Description-Description-Description-Description-Description-Description-Description",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleFontSize + 2,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
