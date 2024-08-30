import 'package:e_esg/pages/IES/live_informations_page.dart';
import 'package:e_esg/pages/IES/lives.dart';
import 'package:e_esg/pages/IES/your_lives.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/Data/live_list.dart';
import 'package:e_esg/models/live.dart';
import 'package:e_esg/models/doctor.dart';
import 'package:e_esg/api/api_Comsumer.dart';
import 'package:e_esg/api/Dio_Consumer.dart';
import 'package:dio/dio.dart';


class Ies extends StatefulWidget {
  final Doctor doctor; 
  const Ies({super.key ,required this.doctor});

  @override
  State<Ies> createState() => _IesState();
}

class _IesState extends State<Ies> {
  late LiveList _liveList;
  List<Live> _thisWeekLives = [];
  List<Live> _yourLives = [];
  List<Live> _allLives = [];
  double sectionPadding = 0;
  double iconButtonSize = 0;
  double titleFontSize = 0;


  @override
  void initState() {
    super.initState();
    final ApiComsumer apiConsumer = DioConsumer(dio: Dio());
    _liveList = LiveList(apiConsumer: apiConsumer);
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _liveList.fetchLiveData();
    setState(() {
      _thisWeekLives = _liveList.thisWeekLives;
      _yourLives = _liveList.getLivesByDoctor(widget.doctor);
      _allLives = _liveList.getLives();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    iconButtonSize = screenWidth * 0.06;
    sectionPadding = screenWidth * 0.04;
    titleFontSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value?Color(0xff141218):Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name:  widget.doctor.name,
              role: "Docteur",
              imagePath: 'assets/images/boy.png',
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Lives pour cette semaine",
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:  _thisWeekLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live:  _thisWeekLives[index],isDarkMode: Cardi.isDarkMode.value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Vos lives",
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => YourLives(doctor: widget.doctor)));
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
                    SizedBox(height: 10),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:_yourLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: _yourLives[index],isDarkMode: Cardi.isDarkMode.value);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Lives",
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Lives()));
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
                    SizedBox(height: 10),
                    SizedBox(
                      height: 290,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _allLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: _allLives[index],isDarkMode: Cardi.isDarkMode.value);
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
          builder: (context) => LiveInformationsPage(),
          settings: RouteSettings(arguments: live),
        ),
      ),
      child: Container(
        width: 250,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isDarkMode?Color(0xff181a1b): Colors.white,
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
                height: 180,
                width: double.infinity,
                child: Image.asset(
                  live.liveImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
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
