import 'package:e_esg/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Live extends Appointment {
  String subject;
  Doctor doctor;
  DateTime date;
  TimeOfDay hour;
  String liveLink;
  String liveImage;


  Live( {
    required this.subject,
    required this.doctor,
    required this.date,
    required this.hour,
    required this.liveLink,
    required this.liveImage,
    Color? color,
  }) : super(startTime: date, endTime: date.add(const Duration(hours: 1)),subject: subject,color:color ?? Colors.blue,);
}