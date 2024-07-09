import 'package:e_esg/pages/IES/statistiques.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class StatistiqueChart extends StatefulWidget {
  final String subject;
  final double proportion;
  final String? userimage;

  StatistiqueChart({
    required this.subject,
    required this.proportion,
    this.userimage,
  });

  @override
  State<StatistiqueChart> createState() => _StatistiqueChartState();
}

class _StatistiqueChartState extends State<StatistiqueChart> {
  double _currentProportion = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), () {
      setState(() {
        _currentProportion = widget.proportion;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.userimage != null
                  ? Container(
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: widget.userimage!.startsWith('https')
                      ? Image.network(widget.userimage!, fit: BoxFit.cover)
                      : Image.asset(widget.userimage!, fit: BoxFit.cover),
                ),
              )
                  : SizedBox(),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  widget.subject,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: titleFontSize-6,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFEAEBF6),
                      ),
                    ),
                    AnimatedContainer(
                      height: 5,
                      width: MediaQuery.of(context).size.width * _currentProportion,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF2E37A4),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              Text(NumberFormat.percentPattern().format(widget.proportion),style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: titleFontSize-5,
                  color: Color(0xFF99EDE9)
              ),)
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
