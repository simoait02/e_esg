import 'package:e_esg/api/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../LoginSignUp/Cardi.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController controller = TextEditingController();
  List<String> messages = [];  // Ensure this is a list of strings

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id=prefs.getInt("IdDoc");
    setState(() {
      messages = prefs.getStringList('${id}_messages') ?? [];
    });
  }

  Future<void> _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id=prefs.getInt("IdDoc");
    await prefs.setStringList('${id}_messages', messages);
  }

  void _sendMessage(String text) async {
    controller.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDoc = prefs.getBool("isDoc")!;
    String? token = isDoc ? prefs.getString('tokenDoc') : prefs.getString('tokenInf');
    setState(() {
      messages.add("You: $text");
    });
    final response = await api.post(
      "http://192.168.59.78:5000/chatbot/ask",
      data: {"message": text},
      headers: {
        "Authorization": "$token",
      },
    );
    setState(() {
      messages.add("Bot: ${response['response']}");
    });
    _saveMessages();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isSender = messages[index].startsWith("You:");
                return MessageBubble(
                  text: messages[index].substring(5), // remove "You: " or "Bot: "
                  isSender: isSender,
                );
              },
            ),
          ),
          Container(
            height: 50,
            width: width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 2,
                color: Cardi.isDarkMode.value
                    ? CupertinoColors.white.withOpacity(0.5)
                    : CupertinoColors.black.withOpacity(0.5),
              ),
            ),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Send a message',
                      hintStyle: TextStyle(
                        color: Cardi.isDarkMode.value
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_circle_up_outlined,
                    color: Cardi.isDarkMode.value
                        ? CupertinoColors.white.withOpacity(0.5)
                        : CupertinoColors.black.withOpacity(0.5),
                  ),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      _sendMessage(controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.8),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: isSender ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSender ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
