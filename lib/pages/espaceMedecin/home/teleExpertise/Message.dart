import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../LoginSignUp/Cardi.dart';

class Message extends StatefulWidget {
  final Map<String,dynamic> name;
  final Map<String,dynamic> profile;
  final Map<String,dynamic> speciality;
  const Message({super.key,required this.name,required this.profile,required this.speciality});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController controller = TextEditingController();
  List messages = [
    MessageBubble(
      text: "Hello, Doctor!",
      isSender: true,
    ),
    MessageBubble(
      text: "Hello! How can I assist you today?",
      isSender: false,
    ),
    MessageBubble(
      text: "I have a question regarding my medication.",
      isSender: true,
    ),
    MessageBubble(
      text: "Sure, please go ahead.",
      isSender: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            ListTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(CupertinoIcons.chevron_back),
              ),
              title: ListTile(
                leading:  Hero(
                  tag: widget.profile["tag"],
                  child: widget.profile["widget"]
                ),
                title: Hero(
                  tag: widget.name["tag"],
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      widget.name["widget"],
                      style: GoogleFonts.aBeeZee(),
                    ),
                  ),
                ),
                subtitle: Hero(
                  tag: widget.speciality["tag"],
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      widget.speciality["widget"],
                      style: GoogleFonts.abel(
                        color: Cardi.isDarkMode.value
                            ? CupertinoColors.white.withOpacity(0.5)
                            : CupertinoColors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color:Color(0x1a2e37a4),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Cardi.isDarkMode.value
                                  ? const Color(0xff141218)
                                  : Colors.white,
                            ],
                            stops: [0.0, 0.05],
                          ).createShader(bounds),
                          blendMode: BlendMode.dst,
                          child: ListView.builder(
                            reverse: false,
                            padding: EdgeInsets.zero,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return messages[index];
                            },
                          ),
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
                                decoration:  InputDecoration.collapsed(
                                  hintText: 'Send a message',
                                  hintStyle: TextStyle(
                                    color: Cardi.isDarkMode.value
                                        ? CupertinoColors.white.withOpacity(0.5)
                                        : CupertinoColors.black.withOpacity(0.5)
                                  )
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
                                  setState(() {
                                    messages.add(
                                      MessageBubble(
                                        text: controller.text,
                                        isSender: true,
                                      ),
                                    );
                                    controller.clear();
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
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
