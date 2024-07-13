import 'package:flutter/material.dart';

class Userdrawer extends StatefulWidget {
  @override
  UserdrawerState createState() => UserdrawerState();
}

class UserdrawerState extends State<Userdrawer> {
  bool isExpanded = false;
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22),
              bottomRight: Radius.circular(22),
            ),
            child: Container(
              height: 150,
              color: Color.fromARGB(255, 17, 117, 199),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/messi.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 110,
                      child: Text(
                        'Yassmine El Moudene',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () {
              print("Settings");
            },
          ),
           ExpansionTile(
              leading: Icon(
                Icons.language,
                color: isExpanded ? Colors.blue : null,
              ),
              title: Text('Langues'),
                onExpansionChanged: (bool expanding) {
                setState(() {
                  isExpanded = expanding;
                });
              },
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  title: Text('Français'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  title: Text('English'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  title: Text('العربية'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          SwitchListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            title: Text('Mode Sombre'),
            value: isDarkMode,
            onChanged: toggleDarkMode,
            secondary: Icon(Icons.brightness_6),
            activeColor: Colors.blue,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            title: Text('Notifications'),
            value: notificationsEnabled,
            onChanged: toggleNotifications,
            secondary: Icon(Icons.notifications),
            activeColor: Colors.blue,
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            leading: Icon(Icons.logout),
            title: Text('Déconnexion'),
            onTap: () {
              print("Log out");
            },
          ),
        ],
      ),
    );
  }
}
