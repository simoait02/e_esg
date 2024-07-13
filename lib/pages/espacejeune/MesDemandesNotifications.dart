import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Invitation {
  final String doctorName;
  final String subject;
  final String date;

  Invitation({
    required this.doctorName,
    required this.subject,
    required this.date,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      doctorName: json['doctorName'],
      subject: json['subject'],
      date: json['date'],
    );
  }
}

class NotificationItem {
  final String title;
  final String message;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    this.isRead = false,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'],
      message: json['message'],
      isRead: json['isRead'],
    );
  }
}

class MesDemandesNotifications extends StatefulWidget {
  @override
  MesDemandesNotificationsState createState() => MesDemandesNotificationsState();
}

class MesDemandesNotificationsState extends State<MesDemandesNotifications> {
  bool isDemandesSelected = true;
  final double whiteContainerHeight = 25.0;

  List<Invitation> invitations = [];
  List<NotificationItem> notifications = [];

  @override
  void initState() {
    super.initState();
    loadInvitationsFromJson();
    loadNotificationsFromJson();
  }

  void loadInvitationsFromJson() async {
    String jsonInvitations = '''
      [
        {"doctorName": "Dr. Mbarki Hamoudi", "subject": "Fievere des enfants", "date": "juillet 03, 2024"},
        {"doctorName": "Dr. Yassmine", "subject": "Autre sujet", "date": "août 14, 2024"},
        {"doctorName": "Dr. Mbarki Hamoudi", "subject": "Fievere des enfants", "date": "juillet 03, 2024"},
        {"doctorName": "Dr. Yassmine", "subject": "Autre sujet", "date": "août 14, 2024"}
      ]
    ''';

    try {
      List<dynamic> parsedJson = jsonDecode(jsonInvitations);
      List<Invitation> loadedInvitations = parsedJson.map((json) => Invitation.fromJson(json)).toList();

      setState(() {
        invitations = loadedInvitations;
      });
    } catch (e) {
      // Handle error
      print("Error parsing invitations JSON: $e");
    }
  }

  void loadNotificationsFromJson() async {
    String jsonNotifications = '''
      [
        {"title": "Une autre Notification", "message": "Vous avez un nouveau message.", "isRead": false},
        {"title": "Nouvelle Notification", "message": "Vous avez un nouveau message.", "isRead": false},
        {"title": "Mise à jour", "message": "Votre application a été mise à jour.", "isRead": false}
      ]
    ''';

    try {
      List<dynamic> parsedJson = jsonDecode(jsonNotifications);
      List<NotificationItem> loadedNotifications = parsedJson.map((json) => NotificationItem.fromJson(json)).toList();

      setState(() {
        notifications = loadedNotifications;
      });
    } catch (e) {
      // Handle error
      print("Error parsing notifications JSON: $e");
    }
  }

  void markNotificationAsRead(NotificationItem notification) {
    setState(() {
      notification.isRead = true;
    });
  }

  int typeNoti = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: "notification",
          child: Container(
            margin: EdgeInsets.only(left: screenWidth * 0.26, right: screenWidth * 0.4),
            child: SvgPicture.asset(
              'assets/images/note_icon.svg',
              width: 40,
              height: 40,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.05),
          child: SizedBox(
            width: screenWidth * 0.9,
            child: CupertinoSlidingSegmentedControl<int>(
              padding: EdgeInsets.all(4),
              groupValue: typeNoti,
              onValueChanged: (int? value) {
                setState(() {
                  typeNoti = value!;
                });
              },
              children: {
                0: buildSegmentedControlItem('Mes Demandes'),
                1: buildSegmentedControlItem('Mes Notifications'),
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.01),
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.8,
                child: typeNoti == 0
                    ? buildDemandesList(screenHeight, screenWidth)
                    : buildNotificationsList(screenHeight, screenWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSegmentedControlItem(String text) {
    return Container(
      padding: EdgeInsets.all(8),
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

  Widget buildDemandesList(double screenHeight, double screenWidth) {
    return ListView.builder(
      itemCount: invitations.length,
      itemBuilder: (BuildContext context, int index) {
        return buildInvitationItem(invitations[index], screenHeight, screenWidth);
      },
    );
  }

  Widget buildNotificationsList(double screenHeight, double screenWidth) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            markNotificationAsRead(notifications[index]);
          },
          child: buildNotificationItem(notifications[index], screenHeight, screenWidth),
        );
      },
    );
  }

  Widget buildInvitationItem(Invitation invitation, double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: screenWidth * 0.03),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                  color: Colors.blue,
                  child: Center(
                    child: Icon(Icons.person, size: screenWidth * 0.1, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invitation.doctorName,
                    style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.003),
                  Text(
                    "invited you to participate in a discussion about",
                    style: TextStyle(fontSize: screenWidth * 0.03),
                  ),
                  SizedBox(height: screenHeight * 0.003),
                  AutoSizeText.rich(
                    TextSpan(
                      style: TextStyle(fontSize: screenWidth * 0.03),
                      children: [
                        TextSpan(
                          text: invitation.subject,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        TextSpan(
                          text: '  le  ',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: invitation.date,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            height: screenHeight * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print("Refuser");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(4),
                    minimumSize: Size(screenWidth * 0.3, screenHeight * 0.045),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(color: Cardi.isDarkMode.value ? CupertinoColors.white.withOpacity(0.5) : CupertinoColors.black.withOpacity(0.5), width: 1),
                  ),
                  child: Text(
                    "Refuser",
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Accepter");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    minimumSize: Size(screenWidth * 0.3, screenHeight * 0.045),
                    backgroundColor: Color(0xFF25B69D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Accepter",
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationItem(NotificationItem notification, double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth * 0.03),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (!notification.isRead)
                Icon(Icons.circle, color: Colors.green, size: screenWidth * 0.02),
              SizedBox(width: screenWidth * 0.02),
              Text(
                notification.title,
                style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            notification.message,
            style: TextStyle(fontSize: screenWidth * 0.03),
          ),
        ],
      ),
    );
  }
}
