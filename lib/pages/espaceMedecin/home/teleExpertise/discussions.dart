import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/plus_infos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../espacejeune/MesDemandesNotifications.dart';
import '../../LoginSignUp/Cardi.dart';

class Discussions extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;
  const Discussions({super.key,required this.isSideBarClosed,
    required this.onSidebarToggle,
  });

  @override
  State<Discussions> createState() => _DiscussionsState();
}

class _DiscussionsState extends State<Discussions> {
  Widget buildSegmentedControlItem(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Cardi.isDarkMode.value ? CupertinoColors.white : CupertinoColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  int typeNoti=0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading:true,
          floating: true,
          snap: true,
          backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
          leading: Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: widget.onSidebarToggle,
              child: widget.isSideBarClosed
                  ? SvgPicture.asset('assets/images/more.svg')
                  : Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    color: Color(0x5e0e1462),
                    shape: BoxShape.circle),
                child: const Icon(CupertinoIcons.clear, color: Color(0xff2e37a4)),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              CupertinoSlidingSegmentedControl<int>(
                padding: const EdgeInsets.all(4),
                groupValue: typeNoti,
                onValueChanged: (int? value) {
                  setState(() {
                    typeNoti = value!;
                  });
                },
                children: {
                  0: buildSegmentedControlItem('Mes invitations'),
                  1: buildSegmentedControlItem('discussions terminées'),
                },
              ),
              SizedBox(height: height*0.02,),
              typeNoti==0?Container(
                padding: const EdgeInsets.all(8),
                decoration:BoxDecoration(
                  color: Cardi.isDarkMode.value?const Color(0xe5212125):const Color(0xfffbfbfd),
                    border: Border.all(color:Cardi.isDarkMode.value?Colors.white24:Colors.black26)
                ),
                child: Column(
                  children: [
                    const ListTile(
                      leading:CircleAvatar(child: Icon(CupertinoIcons.person),),
                      title: Text("simo",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text("Chirurgien"),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText("Motif: ",
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText("Discutons du cas d'un patient souffrant d'une irritation cutanée. Cette discussion abordera les causes potentielles. ",
                            style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff2e37a4)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText("Date: ",
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText("09/04/2024",
                            style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff21c6b7)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText("Time: ",
                          style: GoogleFonts.aBeeZee(
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),
                        Expanded(
                          child: AutoSizeText("09:04",
                            style: GoogleFonts.aBeeZee(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff21c6b7)
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                            child: Container(
                              alignment: Alignment.center,
                              height: height*0.05,
                              width: width*0.3,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.red)
                              ),
                              child: const AutoSizeText(
                                "Refuser",style: TextStyle(
                                color: Colors.red
                              ),
                              ),
                            ),
                            onPressed: (){}
                        ),
                        CupertinoButton(
                            child: Container(
                              alignment: Alignment.center,
                              height: height*0.05,
                              width: width*0.3,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                              ),
                              child: const AutoSizeText(
                                "Accepter",style: TextStyle(
                                  color: Colors.white
                              ),
                              ),
                            ),
                            onPressed: (){}
                        )
                      ],
                    )
                  ],
                ),
              ):GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context)=>PlusInfos())
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Cardi.isDarkMode.value?const Color(0xe5212125):const Color(0xfffbfbfd),
                      border: Border.all(color:Cardi.isDarkMode.value?Colors.white24:Colors.black26)
                  ),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: CircleAvatar(child: Icon(CupertinoIcons.person,size: 20,)),
                        title:Text("simo",style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: AutoSizeText("Chirurgien"),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(),
                      ),
                      Hero(
                        tag: "motif",
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Motif: ",
                                style: GoogleFonts.aBeeZee(
                                  textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Discutons du cas d'un patient souffrant d'une irritation cutanée. Cette discussion abordera les causes potentielles.",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff2e37a4),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                          child: Text("voir plus"))
                    ],
                  ),
                ),
              ),
              SizedBox(height: height*0.1,)
            ],
          ),
        )
      ],
    );
  }
}
