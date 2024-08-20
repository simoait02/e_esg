import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Data/live_list.dart';
import 'package:e_esg/pages/IES/statistiques.dart';
import 'package:flutter/material.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import '../../models/live.dart';
import '../espaceMedecin/LoginSignUp/Cardi.dart';
import '../../models/doctor.dart';
import '../../api/api_Comsumer.dart';
import '../../api/Dio_Consumer.dart';
import 'package:dio/dio.dart';
class EspaceProfessionnel extends StatefulWidget {
  final Doctor doctor; 
  const EspaceProfessionnel({super.key, required this.doctor});

  @override
  State<EspaceProfessionnel> createState() => _EspaceProfessionnelState();
}

class _EspaceProfessionnelState extends State<EspaceProfessionnel> {
  late LiveList _liveList;
  List<Live> _thisWeekLives = [];
  List<Live> _yourLives = [];
  List<Live> _allLives = [];

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
  double sectionPadding=0;
  double titleFontSize =0;
  double iconFontSize =0;
  int index1=6;
  int index2=6;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    sectionPadding = screenWidth*0.04;
    titleFontSize = screenWidth*0.035;
    iconFontSize = screenWidth*0.055;
    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
                name: "Simo",
                role: "Docteur",
                imagePath: 'assets/images/boy.png'),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: sectionPadding ,right: sectionPadding,top: sectionPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    AutoSizeText(
                      "Lives que vous devez animer",
                      style: TextStyle(
                        fontSize: titleFontSize+7,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE6E6FF)
                        ),
                        padding: EdgeInsets.all(7),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.lightbulb_outline,color: Cardi.isDarkMode.value?Colors.black54:Colors.white,),
                                Expanded(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Veuillez cliquer sur une thématique pour accéder au ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "lien du live ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "et aux ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "questions des jeunes.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                                            ),),
                                ),
                              ],
                            ),
                        ),
                      ),),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        color:Cardi.isDarkMode.value?const Color(0x3fc8d3f7): Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Thématique",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Questions des jeunes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  int itemIndex = index;
                  return liveComponent(live:  _yourLives[itemIndex]);
                },
                childCount: min(index1,  _yourLives.length),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                        color: Cardi.isDarkMode.value?const Color(0x3fc8d3f7):Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      child:Center(
                          child: (index1 <  _yourLives.length)?GestureDetector(
                            onTap: ()=>setState(() {
                              index1+=6;
                            }),
                            child: AutoSizeText(
                              "See more"
                            ),
                          ):SizedBox(width: 10,),
                        ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: sectionPadding ,right: sectionPadding,top: sectionPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 50,),
                        AutoSizeText(
                          "Lives que vous avez animés",
                          style: TextStyle(
                            fontSize: titleFontSize+7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                            color: Cardi.isDarkMode.value?const Color(0x3fc8d3f7):Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Thématique",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Questions des jeunes",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context,index) {
                  int itemIndex=index;
                  return liveComponent(live:  _yourLives[itemIndex]);
                },
                childCount:min(index2,  _yourLives.length),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                          color: Cardi.isDarkMode.value?const Color(0x3fc8d3f7):Colors.white,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      child:Center(
                        child: (index2 <  _yourLives.length)?GestureDetector(
                          onTap: ()=>setState(() {
                            index2+=6;
                          }),
                          child: AutoSizeText(
                              "See more"
                          ),
                        ):SizedBox(width: 10,),
                      ),
                    ),
                  ),
                  SizedBox(height: 100,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget liveComponent({required Live live}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:sectionPadding),
      child: Container(
        color:Cardi.isDarkMode.value?const Color(0x3fc8d3f7): Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Divider(
              color: Color(0xffF5F5F6),

            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: Text(
                      live.subject,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:Cardi.isDarkMode.value?Color(0xffE6E6FF): Color(0xff2E37A4),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Reçus",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  flex: 1,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:"Le :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '${live.date.year}-${live.date.month}-${live.date.day}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )
                        )
                      ]
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  flex: 1,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:"à :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: live.hour.format(context),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )
                        )
                      ]
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
