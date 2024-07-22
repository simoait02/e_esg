import 'package:e_esg/pages/IES/live_informations_page.dart';
import 'package:e_esg/pages/IES/lives.dart';
import 'package:e_esg/pages/IES/your_lives.dart';
import 'package:e_esg/pages/espaceInfermier/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
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
      backgroundColor: CardiInf.isDarkMode.value?const Color(0xff141218):Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name: "Simo",
              role: "Docteur",
              imagePath: 'assets/images/boy.png',
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Lives pour cette semaine",
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: thisWeekLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: thisWeekLives[index],isDarkMode: CardiInf.isDarkMode.value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Vos lives",
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const YourLives()));
                          },
                          icon: Container(
                            width: iconButtonSize - 3,
                            height: iconButtonSize - 3,
                            child: SvgPicture.asset(
                                "assets/images/right-icon.svg"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: yourLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: yourLives[index],isDarkMode: CardiInf.isDarkMode.value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Lives",
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Lives()));
                          },
                          icon: Container(
                            width: iconButtonSize - 3,
                            height: iconButtonSize - 3,
                            child: SvgPicture.asset(
                                "assets/images/right-icon.svg"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: allLives[index],isDarkMode: CardiInf.isDarkMode.value);
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

  Widget liveComponent({required Live live,required bool isDarkMode}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LiveInformationsPage(),
          settings: RouteSettings(arguments: live),
        ),
      ),
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isDarkMode?const Color(0xff181a1b): Colors.white,
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                height: 180,
                width: double.infinity,
                child: Image.asset(
                  live.liveImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
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
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                'By ' + live.doctor.name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: titleFontSize / 1.9,
                  color: const Color(0xFF797979),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}