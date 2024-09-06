import 'package:flutter/material.dart';

import 'ChoosLanguage.dart';
import 'main.dart';
class EEsj extends StatefulWidget {
  const EEsj({super.key});

  @override
  State<EEsj> createState() => _EEsjState();
}


class _EEsjState extends State<EEsj> {
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Chooselanguage(onLanguageChanged: (Locale locale) { MyApp.of(context)?.setLocale(locale); },),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool darkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: darkMode?const Color(0xff141218) : Color(0xffF5F5F6),
      body: Align(
        alignment: Alignment.center,
        child:Container(
          width:width*0.8,
            child: Image.asset('assets/images/logo_eesj1.png')) ,
      ),
    );
  }
}
