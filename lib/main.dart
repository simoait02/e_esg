import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/IES/ajoutLive.dart';
import 'pages/IES/propositions.dart';
import 'pages/IES/statistiques.dart';
import 'pages/espacejeune/Consentement.dart';
import 'pages/espacejeune/ies.dart';


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
