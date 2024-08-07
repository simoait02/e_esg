import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Acceuil.dart';
import 'gamescreen.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Acceuil(),
      routes: {
        '/game': (context) => GameScreen(),
      },
    );
  }
}
