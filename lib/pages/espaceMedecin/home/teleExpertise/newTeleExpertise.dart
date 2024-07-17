import 'dart:math';
import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/SideBar.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/TeleExpertise.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/discussions.dart';
import 'package:e_esg/pages/espaceMedecin/home/teleExpertise/medecins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Newteleexpertise extends StatefulWidget {
  const Newteleexpertise({super.key});

  @override
  State<Newteleexpertise> createState() => _NewteleexpertiseState();
}

class _NewteleexpertiseState extends State<Newteleexpertise> with SingleTickerProviderStateMixin {
  bool isSideBarClosed = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  int selectedItem = 1;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
      setState(() {});
    });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSidebarItemSelected(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  Widget _getSelectedWidget() {
    switch (selectedItem) {
      case 1:
        return TeleExpertise(
          isSideBarClosed: isSideBarClosed,
          onSidebarToggle: () {
            if (isSideBarClosed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            setState(() {
              isSideBarClosed = !isSideBarClosed;
            });
          },
        );
      case 2:
        return Discussions(
          isSideBarClosed: isSideBarClosed,
          onSidebarToggle: () {
            if (isSideBarClosed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            setState(() {
              isSideBarClosed = !isSideBarClosed;
            });
          },
        );
      case 3:
        return Medecins(isSideBarClosed: isSideBarClosed,
          onSidebarToggle: () {
            if (isSideBarClosed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            setState(() {
              isSideBarClosed = !isSideBarClosed;
            });
          },
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff2e37a4),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: width * 0.75,
            left: isSideBarClosed ? -width * 0.75 : 0,
            height: height,
            child: Sidebar(
              selectedItem: selectedItem,
              onItemSelected: _onSidebarItemSelected,
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * width * 0.7, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: isSideBarClosed ? BorderRadius.zero : BorderRadius.circular(24),
                  child: Container(
                    color: Cardi.isDarkMode.value ? Color(0xff141218) : Colors.white,
                    child: SafeArea(
                      child: _getSelectedWidget(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
