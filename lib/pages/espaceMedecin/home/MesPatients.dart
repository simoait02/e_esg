import 'package:e_esg/Widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mespatients extends StatefulWidget {
  const Mespatients({super.key});

  @override
  State<Mespatients> createState() => _MespatientsState();
}

class _MespatientsState extends State<Mespatients> {
  Widget buildPatient({required String text}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xff00d3c7)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
  Widget patient(double width){
    return Container(
      width: width,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          color: Color(0x3fc8d3f7),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 40,
                width: 40,
                child: CircleAvatar(
                  child: Image.asset("assets/images/patient.png",fit: BoxFit.fill,),
                ),
              ),
              Text("Sergio marquina",
                style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    )
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildPatient(text: "Male"),
              buildPatient(text: "Maladie"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff2e37a4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff2e37a4)),
                ),
                child: Text(
                  "voir dossier medical",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Poppins",
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(role: "Medcin",name: "simo",imagePath: "assets/images/boy.png",),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top:10),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mes Patients",style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )
                        ),),
                        Icon(Icons.sort_rounded)
                      ],
                    ),
                    SizedBox(height: 15,),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),
                    patient(width),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}