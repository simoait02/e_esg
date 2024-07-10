import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});
  @override
  ChatbotState createState() => ChatbotState();
}

class ChatbotState extends State<Chatbot> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  int selectedIndex = 0;

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      setState(() {
        messages.add({"type": "user", "text": controller.text});
        messages
            .add({"type": "bot", "text": "This is a response from the bot."});
        controller.clear();
      });
    }
  }

  void resendMessage(String messageText) {
    setState(() {
      messages.add({"type": "user", "text": messageText});
      messages.add({
        "type": "bot",
        "text": "This is a regenerated response from the bot."
      });
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
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color:
              isUser ? Color.fromARGB(255, 49, 146, 225) : Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageText,
                  style: TextStyle(color: Colors.black),
                ),
                if (!isUser)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up, size: 16),
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
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy, size: 16),
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
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessage(messages[index], screenWidth);
              },
            ),
          ),
          Container(
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_circle_up_outlined,color: Colors.black.withOpacity(0.5),),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
