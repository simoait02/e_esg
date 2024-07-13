import 'package:e_esg/AccountType.dart';
import 'package:e_esg/Widgets/NavigationBarJeune.dart';
import 'package:e_esg/pages/IES/ies_doctor.dart';
import 'package:e_esg/pages/IES/live_informations_page.dart';
import'package:e_esg/pages/IES/lives.dart';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import'package:e_esg/pages/espacejeune/login_signup/Card.dart';
import'package:e_esg/pages/IES/ajoutLive.dart';
import'package:e_esg/pages/IES/live_informations_page.dart';
import'package:e_esg/pages/IES/lives.dart';
import'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import'package:e_esg/pages/espacejeune/MesDemandesNotifications.dart';
import'package:e_esg/pages/espacejeune/dossierMedical1.dart';
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
      home: Accounttype(),
    );
  }
}
