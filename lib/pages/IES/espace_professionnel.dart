import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Data/live_list.dart';
import 'package:e_esg/pages/IES/statistiques.dart';
import 'package:flutter/material.dart';

import '../../Widgets/custom_sliver_app_bar.dart';
import '../../models/live.dart';
import '../espaceMedecin/LoginSignUp/Cardi.dart';
class EspaceProfessionnel extends StatefulWidget {
  const EspaceProfessionnel({super.key});

  @override
  State<EspaceProfessionnel> createState() => _EspaceProfessionnelState();
}

class _EspaceProfessionnelState extends State<EspaceProfessionnel> {
  double sectionPadding=0;
  double titleFontSize =0;
  double iconFontSize =0;
  int pagenumber=1;
  int index1=0;
  int numberOfPages = (yourLives.length + 5) ~/ 6;
  int pagenumber2=1;
  int index2=0;
  int numberOfPages2 = (yourLives.length + 5) ~/ 6;
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
                name: "Liam Michael",
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
                          Divider(
                            color: Color(0xffF5F5F6),

                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context,index) {
                      int itemIndex=index1+index;
                  return liveComponent(live: yourLives[itemIndex]);
                },
                childCount:min(6, yourLives.length-index1),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sectionPadding),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                        color: Cardi.isDarkMode.value?const Color(0x3fc8d3f7):Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("De ${index1+1} a ${min(index1+6,yourLives.length)} de ${yourLives.length} entrées",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                          ),
                          Spacer(),
                          Visibility(visible:!(pagenumber==1),child: IconButton(onPressed: (){setState(() {
                            pagenumber--;
                          });}, icon: Icon(Icons.navigate_before,color: Colors.black,))),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                index1=6*(pagenumber-1);
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:index1==6*(pagenumber-1)?Color(0xff2E37A4):Colors.white
                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(child: Text("$pagenumber",style: TextStyle(color: index1==6*(pagenumber-1)?Colors.white:Color(0xff2E37A4),fontWeight: FontWeight.w600),)),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Visibility(visible:6*pagenumber!=yourLives.length,child: GestureDetector(
                            onTap: (){
                              setState(() {
                                index1=6*pagenumber;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:index1==6*pagenumber?Color(0xff2E37A4):Colors.white
                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(child: Text("${pagenumber+1}",style: TextStyle(color: index1==6*pagenumber?Colors.white:Color(0xff2E37A4),fontWeight: FontWeight.w600),)),
                            ),
                          ),),
                          Visibility(visible:!(pagenumber==numberOfPages||pagenumber+1==numberOfPages),child: IconButton(onPressed: (){setState(() {
                            pagenumber++;
                          });}, icon: Icon(Icons.navigate_next,color: Colors.black,))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
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
                              Divider(
                                color: Color(0xffF5F5F6),

                              )
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
                  int itemIndex=index2+index;
                  return liveComponent(live: yourLives[itemIndex]);
                },
                childCount:min(6, yourLives.length-index2),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: sectionPadding,right: sectionPadding,bottom: 30),
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                          color:Cardi.isDarkMode.value?const Color(0x3fc8d3f7): Colors.white,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("De ${index2+1} a ${min(index2+6,yourLives.length)} de ${yourLives.length} entrées",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                          ),
                          Spacer(),
                          Visibility(visible:!(pagenumber2==1),child: IconButton(onPressed: (){setState(() {
                            pagenumber2--;
                          });}, icon: Icon(Icons.navigate_before,color: Colors.black,))),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                index2=6*(pagenumber2-1);
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:index2==6*(pagenumber2-1)?Color(0xff2E37A4):Colors.white
                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(child: Text("$pagenumber2",style: TextStyle(color: index2==6*(pagenumber2-1)?Colors.white:Color(0xff2E37A4),fontWeight: FontWeight.w600),)),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Visibility(visible:6*pagenumber2!=yourLives.length,child: GestureDetector(
                            onTap: (){
                              setState(() {
                                index2=6*pagenumber;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:index2==6*pagenumber?Color(0xff2E37A4):Colors.white
                              ),
                              padding: EdgeInsets.all(5),
                              child: Center(child: Text("${pagenumber2+1}",style: TextStyle(color: index2==6*pagenumber2?Colors.white:Color(0xff2E37A4),fontWeight: FontWeight.w600),)),
                            ),
                          ),),
                          Visibility(visible:!(pagenumber2==numberOfPages2||pagenumber2+1==numberOfPages2),child: IconButton(onPressed: (){setState(() {
                            pagenumber2++;
                          });}, icon: Icon(Icons.navigate_next,color: Colors.black,))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 60,)
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
            Divider(
              color: Color(0xffF5F5F6),

            )
          ],
        ),
      ),
    );
  }
}
