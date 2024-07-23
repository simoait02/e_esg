import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../brick_breaker.dart';
import '../config.dart';
import 'overlay_screen.dart'; // Add this import
import 'score_card.dart'; // And this one too

class GameApp extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;
  // Modify this line
  const GameApp({super.key,required this.isSideBarClosed,required this.onSidebarToggle});

  @override // Add from here...
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  } // To here.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff184e77),
          displayColor: const Color(0xff184e77),
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: [

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffa9d6e5),
                    Color(0xfff2e8cf),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      // Modify from here...
                      children: [
                        ScoreCard(score: game.score),
                        Expanded(
                          child: FittedBox(
                            child: SizedBox(
                              width: gameWidth,
                              height: gameHeight,
                              child: GameWidget(
                                game: game,
                                overlayBuilderMap: {
                                  PlayState.welcome.name: (context, game) =>
                                      const OverlayScreen(
                                        title: 'TAP TO PLAY',
                                        subtitle: 'swipe',
                                      ),
                                  PlayState.gameOver.name: (context, game) =>
                                      const OverlayScreen(
                                        title: 'G A M E   O V E R',
                                        subtitle: 'Tap to Play Again',
                                      ),
                                  PlayState.won.name: (context, game) =>
                                      const OverlayScreen(
                                        title: 'Y O U   W O N ! ! !',
                                        subtitle: 'Tap to Play Again',
                                      ),
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), // To here.
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 70,
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: widget.onSidebarToggle,
                  child: widget.isSideBarClosed
                      ? SvgPicture.asset('assets/images/more.svg')
                      : Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                        color: Color(0x5e0e1462), shape: BoxShape.circle),
                    child: const Icon(CupertinoIcons.clear,
                        color: Color(0xff2e37a4)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
