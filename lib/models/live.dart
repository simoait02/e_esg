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

  Live({
    required this.subject,
    required this.doctor,
    required this.date,
    required this.hour,
    required this.liveLink,
    required this.liveImage,
    Color? color,
  }) : super(
          startTime: date,
          endTime: date.add(const Duration(hours: 1)),
          subject: subject,
          color: color ?? Colors.blue,
        );

  // Méthode fromJson pour créer un objet Live à partir d'un JSON
  factory Live.fromJson(Map<String, dynamic> json) {
    return Live(
      subject: json['subject'] ?? '',
      doctor: Doctor.fromJson(json['doctor'] ?? {}),
      date: DateTime.parse(json['date']),
      hour: TimeOfDay(
        hour: int.parse(json['hour'].split(":")[0]),
        minute: int.parse(json['hour'].split(":")[1]),
      ),
      liveLink: json['liveLink'] ?? '',
      liveImage: json['liveImage'] ?? '',
      color: json['color'] != null
          ? Color(int.parse(json['color'], radix: 16))
          : Colors.blue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'doctor': doctor.toJson(),
      'date': date.toIso8601String(),
      'hour': '${hour.hour}:${hour.minute}',
      'liveLink': liveLink,
      'liveImage': liveImage,
      'color': color?.value.toRadixString(16),
    };
  }
}
