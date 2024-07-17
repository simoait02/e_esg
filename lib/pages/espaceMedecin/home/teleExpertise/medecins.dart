import 'package:e_esg/pages/espaceMedecin/LoginSignUp/Cardi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Medecins extends StatefulWidget {
  final bool isSideBarClosed;
  final VoidCallback onSidebarToggle;
  const Medecins({super.key,required this.isSideBarClosed,
    required this.onSidebarToggle,
  });

  @override
  State<Medecins> createState() => _MedecinsState();
}

class _MedecinsState extends State<Medecins> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading:true,
          floating: true,
          snap: true,
          backgroundColor: Cardi.isDarkMode.value ? const Color(0xff141218) : Colors.white,
          leading: Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
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
                    color: Color(0x5e0e1462),
                    shape: BoxShape.circle),
                child: const Icon(CupertinoIcons.clear, color: Color(0xff2e37a4)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
