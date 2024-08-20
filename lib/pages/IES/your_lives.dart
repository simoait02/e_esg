import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/material.dart';
import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:e_esg/Widgets/search.dart';
import 'package:e_esg/Data/live_list.dart'; 
import 'package:e_esg/models/live.dart';
import 'live_informations_page.dart';
import 'package:e_esg/models/doctor.dart'; 
import '../../api/api_Comsumer.dart';
import '../../api/Dio_Consumer.dart';
import 'package:dio/dio.dart';

class YourLives extends StatefulWidget {
  final Doctor doctor;
  const YourLives({super.key, required this.doctor});

  @override
  State<YourLives> createState() => _YourLivesState();
}

class _YourLivesState extends State<YourLives> {
  late LiveList _liveList;
  List<Live> _foundedLives = [];
  double sectionPadding = 16.0; 
  double titleFontSize = 20.0; 

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
      _foundedLives = _liveList.getLivesByDoctor(widget.doctor); 
    });
  }

  void onSearch(String search) {
    setState(() {
      _foundedLives = _liveList.getLivesByDoctor(widget.doctor).where((live) {
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
                    IconButton(onPressed:()=>Navigator.pop(context), icon: Container(child:  Image.asset(
                      "assets/images/fleche.png",
                      width: 20,
                      height: 20,
                      color: Color(0xff2E37A4),
                    ),)),
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
                      hintText: 'Rechercher vos lives',
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
