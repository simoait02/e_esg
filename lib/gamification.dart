import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Gamification extends StatefulWidget {
  const Gamification({super.key});

  @override
  State<Gamification> createState() => _GamificationState();
}

class _GamificationState extends State<Gamification> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpeg"),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Positioned(
            left: width*0.92,
            top: height*0.05,
            child: Icon(CupertinoIcons.clear_circled,size: 50,)
          ),

        ],
      ),
    );
  }
}
