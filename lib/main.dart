import 'package:e_esg/Widgets/NavigationBarJeune.dart';
import 'package:e_esg/pages/espaceInfermier/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/Chatbot.dart';
import 'package:e_esg/pages/espacejeune/dossierMedical.dart';
import 'package:e_esg/pages/espacejeune/dossierMedical1.dart';
import 'package:e_esg/pages/espacejeune/ies.dart';
import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
import 'package:e_esg/pages/espacejeune/testpsy1.dart';
import 'package:e_esg/pages/espacejeune/testpsy2.dart';
import 'package:e_esg/pages/espacejeune/testpsy3.dart';
import 'package:e_esg/pages/espacejeune/testpsy4.dart';
import 'package:e_esg/pages/espacejeune/testpsy5.dart';
import'package:flutter/cupertino.dart';
import'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Ies(),
);
  }
}
