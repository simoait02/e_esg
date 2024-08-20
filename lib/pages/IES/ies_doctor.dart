import 'package:e_esg/pages/IES/live_informations_page.dart';
import 'package:e_esg/pages/IES/your_lives.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/Data/live_list.dart';
import 'package:e_esg/models/live.dart';
import 'lives.dart'; 
import '../../models/doctor.dart';
import '../../api/api_Comsumer.dart';
import '../../api/Dio_Consumer.dart';
import 'package:dio/dio.dart';

class IesDoctor extends StatefulWidget {
  final Doctor doctor; 
  const IesDoctor({super.key, required this.doctor});

  @override
  State<IesDoctor> createState() => _IesDoctorState();
}

class _IesDoctorState extends State<IesDoctor> {
  late LiveList _liveList;
  List<Live> _thisWeekLives = [];
  List<Live> _yourLives = [];
  List<Live> _allLives = [];
  double sectionPadding = 0;
  double iconButtonSize = 0;
  double titleFontSize = 0;
  double width=0;
  double height=0;


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
    final screenHeight = MediaQuery.of(context).size.height;

    width=screenWidth;
    height=screenHeight;

    iconButtonSize = screenWidth * 0.06;
    sectionPadding = screenWidth * 0.04;
    titleFontSize = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: Color(0xffF5F5F6),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              name: widget.doctor.name,
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
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _thisWeekLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: _thisWeekLives[index]);
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>YourLives(doctor: widget.doctor)));
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
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _yourLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: _yourLives[index]);
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
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _allLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: _allLives[index]);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                height: 170, // Adjust the height as per your requirement
                width: double.infinity,
                child: Image.asset(
                  live.liveImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5,right: 5,top: 7),
                child: Text(
                  live.subject,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: width * 0.04, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
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
