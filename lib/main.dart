import 'package:e_esg/pages/IES/ajoutLive.dart';
import 'package:e_esg/pages/IES/calendrier.dart';
import 'package:e_esg/pages/espaceMedecin/Card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calendrier(),
    );
  }
}
