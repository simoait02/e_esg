import 'package:e_esg/pages/espacejeune/login_signup/Cardi.dart';
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
      home: CardiJeune(),
    );
  }
}
