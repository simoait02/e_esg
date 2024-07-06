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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double iconButtonSize = screenWidth * 0.10;
    double sectionPadding = screenWidth * 0.04;
    double titleFontSize = screenWidth * 0.06 -8; // Adjust this as needed

    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.white,
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
            Spacer(),
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
                    fontSize: titleFontSize - 8,
                    color: Color(0xFF2E37A4),
                  ),
                ),
                Text(
                  role,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: titleFontSize - 8,
                    color: Color(0xFFABAFDB),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Container(
                width: iconButtonSize,
                height: 2 * (titleFontSize - 8) + 16,
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
    );
  }
}
