import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});
  @override
  ChatbotState createState() => ChatbotState();
}

class ChatbotState extends State<Chatbot> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  int selectedIndex = 0;

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add({"type": "user", "text": controller.text});
        messages.add({"type": "bot", "text": "This is a response from the bot."});
        controller.clear();
      });
    }
  }

  void resendMessage(String messageText) {
    setState(() {
      messages.add({"type": "user", "text": messageText});
      messages.add({"type": "bot", "text": "This is a regenerated response from the bot."});
    });
  }

  Widget buildMessage(Map<String, String> message, double screenWidth) {
    bool isUser = message['type'] == 'user';
    String messageText = message['text'] ?? '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser)
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/esj.png'),
            backgroundColor: Colors.grey[200],
          ),
        if (!isUser) SizedBox(width: 8),
        Expanded(
          child: Container(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isUser ? Color(0xff99EDE9) : Color(0xff9196CD),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  messageText,
                  style: TextStyle(color: Colors.white),
                ),
                if (!isUser)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up, size: 16, color: Color(0xffEAEBF6)),
                        onPressed: () {
                          print('Liked message: $messageText');
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          resendMessage(messageText);
                        },
                        child: Icon(
                          Icons.refresh,
                          size: 16,
                          color: Color(0xffEAEBF6),
                        ),
                      ),
                      SizedBox(width: 4), // Reduced padding between icons
                      IconButton(
                        icon: Icon(Icons.copy, size: 16, color: Color(0xffEAEBF6)),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: messageText));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied to clipboard'),
                              backgroundColor: Color.fromARGB(255, 27, 76, 117),
                            ),
                          );
                          print('Copied message: $messageText');
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (isUser) SizedBox(width: 8),
        if (isUser)
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.jpg'),
            backgroundColor: Colors.grey[200],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Cardi.isDarkMode.value?Color(0xff141218):Colors.white,
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              // Add your drawer content here
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              // Add more drawer items as needed
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) => buildMessage(messages[index], screenWidth),
                            childCount: messages.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: screenWidth * 0.95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 2, color: Color(0xff00D3C7)),
                  ),
                  margin: EdgeInsets.only(bottom: 10, top: 5),
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration.collapsed(hintText: 'Send a message'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_circle_up_outlined, color: Color(0xff00D3C7)),
                        onPressed: sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Color(0xff00D3C7),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(Icons.menu, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
