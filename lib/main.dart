import 'package:e_esg/Widgets/NavigationBarJeune.dart';
import 'package:e_esg/pages/IES/live_informations_page.dart';
import 'package:e_esg/pages/IES/lives.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Card.dart';
import 'package:flutter/cupertino.dart';
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
      home: Cardi(),
    );
  }
}
