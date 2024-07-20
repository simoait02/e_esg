import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/vote_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../Data/live_list.dart';
import '../../Widgets/ajout_proposition_dialog.dart';
import '../../Widgets/custom_sliver_app_bar.dart';
import '../../models/live.dart';
import '../IES/live_informations_page.dart';
import '../IES/lives.dart';
import '../IES/statistiques.dart';

class Ies extends  StatefulWidget {
  const Ies({super.key});


  @override
   IesState createState() => IesState();
}
class IesState extends State<Ies> {
  double width=0;
  double height=0;
  void addNewProposition(String subject) {

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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: isDarkMode?Color(0xff141218):Color(0xffF5F5F6),
      body:SafeArea(
        child: CustomScrollView(
          slivers: [
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
                        itemCount: thisWeekLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: thisWeekLives[index],isDarkMode: isDarkMode);
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
                        itemCount: allLives.length,
                        itemBuilder: (context, index) {
                          return liveComponent(live: allLives[index],isDarkMode: isDarkMode);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (context) => AddPropositionDialog(
                              onConfirm: addNewProposition,
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          border: Border.all(
                            color: Color(0xFFEAEBF6),
                            width: 1.0,
                          ),
                          color: Color(0xff2F38A5)
                        ),
                        padding: EdgeInsets.all(sectionPadding),
                        child: Center(
                          child: AutoSizeText(
                            'Proposer',
                            style: TextStyle(
                              fontSize: titleFontSize - 2,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: (){showDialog(
                          context: context,
                          builder: (context) => VoteDialog(
                              onConfirm: addNewProposition));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          border: Border.all(
                            color: Color(0xFFEAEBF6),
                            width: 1.0,
                          ),
                            color: Color(0xff2F38A5)
                        ),
                        padding: EdgeInsets.all(sectionPadding),
                        child: Center(
                          child: AutoSizeText(
                            'Voter',
                            style: TextStyle(
                              fontSize: titleFontSize - 2,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.1,)
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
  Widget liveComponent({required Live live,required bool isDarkMode}) {
    return GestureDetector(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveInformationsPage(),settings: RouteSettings(arguments: live))),
      child: Container(
        width: 280,
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color:isDarkMode?Color(0xff141218):Colors.white,
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

class SuggestionBox extends StatelessWidget {
  final TextEditingController suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Laissez une suggestion",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: suggestionController,
            maxLines: 2,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Suggestion',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 209, 208, 208),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          TextField(
            controller: suggestionController,
            maxLines: 4,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Décrivez votre suggestion',
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 209, 208, 208),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Color(0xff2E37A4)),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  print('Suggestion envoyée: ${suggestionController.text}');
                  suggestionController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Suggestion envoyée'),
                      backgroundColor: Colors.green.shade400,
                    ),
                  );
                },
                child: Text('Envoyer'),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

