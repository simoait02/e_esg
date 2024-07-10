import 'package:e_esg/pages/IES/live_informations_page.dart';
import 'package:e_esg/pages/IES/lives.dart';
import 'package:e_esg/pages/IES/your_lives.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/Data/live_list.dart';
import 'package:e_esg/models/live.dart';
class Ies extends StatefulWidget {
  const Ies({super.key});

  @override
  State<Ies> createState() => _IesState();
}

class _IesState extends State<Ies> {
  double sectionPadding = 0;
  double iconButtonSize = 0;
  double titleFontSize = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    iconButtonSize = screenWidth * 0.06;
    sectionPadding = screenWidth * 0.04;
    titleFontSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name: "Chaimae Bouti",
              role: "docteur",
              imagePath: 'assets/images/boy.png',
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(sectionPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Text(
                      "Lives pour cette semaine",
                      style: TextStyle(
                        fontSize: titleFontSize,
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
                          return liveComponent(live: thisWeekLives[index]);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Vos lives",
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>YourLives()));
                          },
                          icon: Container(
                            width: iconButtonSize - 3,
                            height: iconButtonSize - 3,
                            child: SvgPicture.asset("assets/images/right-icon.svg"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: yourLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: yourLives[index]);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Lives",
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Lives()));
                          },
                          icon: Container(
                            width: iconButtonSize - 3,
                            height: iconButtonSize - 3,
                            child: SvgPicture.asset("assets/images/right-icon.svg"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: allLives[index]);
                        },
                      ),
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

  Widget liveComponent({required Live live}) {
    return GestureDetector(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveInformationsPage(),settings: RouteSettings(arguments: live))),
      child: Container(
        width: 250,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                height: 180, // Adjust the height as per your requirement
                width: double.infinity,
                child: Image.asset(
                  live.liveImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
                child: Text(
                  live.subject,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: titleFontSize / 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 10),
              child: Text(
                'By ' + live.doctor.name,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: titleFontSize / 1.9,
                    color: Color(0xFF797979)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
