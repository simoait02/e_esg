import 'package:flutter/material.dart';
import 'package:e_esg/models/live.dart';
import 'package:e_esg/api/api_Comsumer.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/models/doctor.dart';  
import 'package:shared_preferences/shared_preferences.dart';

class LiveList {
  final ApiComsumer apiConsumer;

  LiveList({required this.apiConsumer});

  List<Live> thisWeekLives = [];
  List<Live> allLives = [];
  Map<Doctor, List<Live>> doctorLivesMap = {};  

  Future<void> fetchLiveData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await apiConsumer.get(
        EndPoints.GetAllLives,
        queryParameters: {}, 
        headers: {'Authorization': token}, 
      );
      
      List<dynamic> liveJson = response.data;
      List<Live> liveSessions = liveJson.map((json) => Live.fromJson(json)).toList();

      DateTime now = DateTime.now();
      thisWeekLives = liveSessions.where((live) {
        return live.date.isAfter(now.subtract(Duration(days: now.weekday - 1))) &&
               live.date.isBefore(now.add(Duration(days: 7 - now.weekday)));
      }).toList();

      allLives = liveSessions;

      doctorLivesMap.clear();  
      for (var live in liveSessions) {
        if (doctorLivesMap.containsKey(live.doctor)) {
          doctorLivesMap[live.doctor]!.add(live);
        } else {
          doctorLivesMap[live.doctor] = [live];
        }
      }

    } catch (e) {
      print('Error fetching live sessions: $e');
    }
  }

  List<Live> getLives() {
    List<Live> lives = <Live>[];
    lives.addAll(allLives);
    return lives;
  }


  List<Live> getLivesByDoctor(Doctor doctor) {
    return doctorLivesMap[doctor] ?? [];
  }
}
