import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String name;
  final String role;
  final String imagePath;

  CustomSliverAppBar({
    required this.name,
    required this.role,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double iconButtonSize = screenWidth * 0.10;
    double sectionPadding = screenWidth * 0.04;
    double titleFontSize = screenWidth * 0.06 -6;
    return ValueListenableBuilder(
      valueListenable: Cardi.isDarkMode,
      builder: (BuildContext context, bool value, Widget? child) {
      return SliverAppBar(
        bottom:PreferredSize(
          preferredSize: Size.fromHeight(iconButtonSize-30),
          child: Text(''),
        ),
        automaticallyImplyLeading:false,
        floating: true,
        snap: true,
        backgroundColor: Cardi.isDarkMode.value?Color(0xff181a1b): Colors.white,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.symmetric(horizontal: sectionPadding),
          title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  width: iconButtonSize,
                  height: iconButtonSize,
                  child: SvgPicture.asset('assets/images/search_icon.svg'),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Container(
                  width: iconButtonSize,
                  height: iconButtonSize,
                  child: SvgPicture.asset('assets/images/note_icon.svg'),
                ),
                onPressed: () {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: titleFontSize ,
                      color: Color(0xFF2E37A4),
                    ),
                  ),
                  Text(
                    role,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: titleFontSize ,
                      color: Color(0xFFABAFDB),
                    ),
                  ),
                ],
              ),

              IconButton(
                icon: Container(
                  width: iconButtonSize,
                  height: 2 * titleFontSize  + 16,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset(imagePath),
                ),
                onPressed: () {
                  print('Profile button pressed');
                },
              ),
            ],
          ),
        ),
      );}
    );
  }
}
