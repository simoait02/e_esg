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
  double sectionPadding = 16.0; // Example padding value
  double titleFontSize = 20.0; // Example font size value

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "Vos lives",
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
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveInformationsPage(),settings: RouteSettings(arguments: live))),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
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
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
              child: Text(
                live.subject,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize -3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 13),
              child: Text(
                'By ' + live.doctor.name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: titleFontSize -7,
                  color: Color(0xFF797979),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}