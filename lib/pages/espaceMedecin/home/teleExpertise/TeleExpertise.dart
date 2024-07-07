import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';


class TeleExpertise extends StatefulWidget {
  const TeleExpertise({super.key});

  @override
  State<TeleExpertise> createState() => _TeleExpertiseState();
}

class _TeleExpertiseState extends State<TeleExpertise> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(

      )
    );
  }
}
