import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_esg/Widgets/pulse_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SidebarYong extends StatefulWidget {
  final int selectedItem;
  final ValueChanged<int> onItemSelected;

  SidebarYong({super.key, required this.selectedItem, required this.onItemSelected});

  @override
  State<SidebarYong> createState() => _SidebarYongState();
}

class _SidebarYongState extends State<SidebarYong> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        width: width * 0.75,
        height: double.infinity,
        color: const Color(0xff2e37a4),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation:0,
                          color: Colors.transparent,
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.white24,
                              child: Icon(CupertinoIcons.person, color: Colors.white),
                            ),
                            title: AutoSizeText(
                              "simo",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            subtitle: AutoSizeText(
                              appLocalizations!.jeune,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(
                                'assets/images/note_icon.svg',
                                color: Colors.purple.shade100,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 5,
                              child: PulseAnimation(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20,)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                    child: AutoSizeText(
                      appLocalizations.browse.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        height: 56,
                        width: widget.selectedItem == 1 ? width * 0.75 : 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF6792FF),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          widget.onItemSelected(1);
                        },
                        leading: SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            "assets/images/accueil.svg",
                            color: Colors.purple.shade100,
                          ),
                        ),
                        title: Text(
                          appLocalizations.home,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        height: 56,
                        width: widget.selectedItem == 2 ? width * 0.75 : 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF6792FF),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          widget.onItemSelected(2);
                        },
                        leading: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                            "assets/images/game.png",
                            color: Colors.purple.shade100,
                          ),
                        ),
                        title: Text(
                          appLocalizations.gamificatiom,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        height: 56,
                        width: widget.selectedItem == 3 ? width * 0.75 : 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF6792FF),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          widget.onItemSelected(3);
                        },
                        leading: SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            "assets/images/settings.svg",
                            color: Colors.purple.shade100,
                          ),
                        ),
                        title: Text(
                          appLocalizations.settings,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
