import 'dart:convert';
import 'package:flutter/material.dart';

class Invitation {
  final String doctorName;
  final String subject;
  final String date;

  Invitation({
    required this.doctorName,
    required this.subject,
    required this.date,
  });
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

    List<dynamic> parsedJson = jsonDecode(jsonInvitations);
    List<Invitation> loadedInvitations = parsedJson.map((json) {
      return Invitation(
        doctorName: json['doctorName'],
        subject: json['subject'],
        date: json['date'],
      );
    }).toList();

    setState(() {
      invitations = loadedInvitations;
    });
  }

  void loadNotificationsFromJson() async {
    String jsonNotifications = '''
      [
        {"title": "Une autre Notification", "message": "Vous avez un nouveau message.", "isRead": false},
        {"title": "Nouvelle Notification", "message": "Vous avez un nouveau message.", "isRead": false},
        {"title": "Mise à jour", "message": "Votre application a été mise à jour.", "isRead": false}
      ]
    ''';

    List<dynamic> parsedJson = jsonDecode(jsonNotifications);
    List<NotificationItem> loadedNotifications = parsedJson.map((json) {
      return NotificationItem(
        title: json['title'],
        message: json['message'],
        isRead: json['isRead'],
      );
    }).toList();

    setState(() {
      notifications = loadedNotifications;
    });
  }
  
  void markNotificationAsRead(NotificationItem notification) {
    setState(() {
      notification.isRead = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            SizedBox(width: screenWidth * 0.2),
            Image.asset(
              'assets/images/Notifications1.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.04,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      alignment: isDemandesSelected ? Alignment.centerLeft : Alignment.centerRight,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        margin: EdgeInsets.all(2),
                        width: screenWidth * 0.4 - 2,
                        height: whiteContainerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDemandesSelected = true;
                            });
                          },
                          child: Container(
                            width: screenWidth * 0.4,
                            alignment: Alignment.center,
                            child: Text(
                              'Mes Demandes',
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDemandesSelected = false;
                            });
                          },
                          child: Container(
                            width: screenWidth * 0.4,
                            alignment: Alignment.center,
                            child: Text(
                              'Mes Notifications',
                              style: TextStyle(
                                fontSize: screenWidth * 0.03,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.8,
                child: isDemandesSelected ? buildDemandesList(screenHeight, screenWidth) : buildNotificationsList(screenHeight, screenWidth),
              ),
            ],
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
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Expanded(
                child: Column(
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
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: screenWidth * 0.03, color: Colors.black),
                        children: [
                          TextSpan(
                            text: invitation.subject,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' le ',
                          ),
                          TextSpan(
                            text: invitation.date,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.003),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print("Refuser");
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            minimumSize: Size(screenWidth * 0.2, screenHeight * 0.05),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Refuser",
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        ElevatedButton(
                          onPressed: () {
                            print("Accepter");
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            minimumSize: Size(screenWidth * 0.2, screenHeight * 0.05),
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
                  ],
                ),
              ),
            ],
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


