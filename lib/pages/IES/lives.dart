import 'package:flutter/material.dart';

import 'package:e_esg/Data/live_list.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/Widgets/search.dart';
import 'package:e_esg/models/live.dart';
import 'live_informations_page.dart';
class Lives extends StatefulWidget {
  const Lives({super.key});

  @override
  State<Lives> createState() => _LivesState();
}

class _LivesState extends State<Lives> {

  List<Live> _foundedLives = [];
  double sectionPadding = 16.0;
  double titleFontSize = 20.0;

  @override
  void initState() {
    super.initState();
    _foundedLives = allLives; 
  }

  void onSearch(String search) {
    setState(() {
      _foundedLives = allLives.where((live) {
        return live.subject.toLowerCase().contains(search.toLowerCase());
      }).toList();
    });
  }
  double width=0;
  double height=0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    width=screenWidth;
    height=screenHeight;
    return Scaffold(
      backgroundColor: isDarkMode?Color(0xff141218):Color(0xffF5F5F6),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Text(
                          "Les lives",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: titleFontSize+10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    CustomSearch(
                      hintText: 'Rechercher lives',
                      onchanged: (value) => onSearch(value),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return liveComponent(live: _foundedLives[index]);
                },
                childCount: _foundedLives.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget liveComponent({required Live live}) {
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
        margin: EdgeInsets.all( 8),
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
                height: 200, // Adjust the height as per your requirement
                width: double.infinity,
                child: Image.asset(
                  live.liveImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 7),
              child: Text(
                live.subject,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                  horizontal: width * 0.02,
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(live.doctor.profil),
                ),
              ),
              title: Text(
                live.doctor.name,
                style: TextStyle(fontSize: width * 0.04),
              ),
              subtitle: Text(
                'Date : ${live.date.day}/${live.date.month}/${live.date.year} à ${live.hour.format(context)}',
                style: TextStyle(fontSize: width * 0.03),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
