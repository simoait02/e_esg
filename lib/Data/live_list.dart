import 'package:e_esg/Data/doctor_list.dart';

import '../models/live.dart';

import 'dart:math';
import 'package:flutter/material.dart';



DateTime date1=DateTime(2024, 7, 3, Random().nextInt(24), Random().nextInt(60));
DateTime date2=DateTime(2024, 7,5, Random().nextInt(24), Random().nextInt(60));
DateTime date3=DateTime(2024, 7, 12, Random().nextInt(24), Random().nextInt(60));
DateTime date4=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date5=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date6=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date7=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date8=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date9=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date10=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date11=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date12=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date13=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date14=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date15=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date16=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date17=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date18=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date19=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date20=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
DateTime date21=DateTime(2024, Random().nextInt(12) + 1, Random().nextInt(28) + 1, Random().nextInt(24), Random().nextInt(60));
TimeOfDay time1= TimeOfDay.fromDateTime(date1);
TimeOfDay time2= TimeOfDay.fromDateTime(date2);
TimeOfDay time3= TimeOfDay.fromDateTime(date3);
TimeOfDay time4= TimeOfDay.fromDateTime(date4);
TimeOfDay time5= TimeOfDay.fromDateTime(date5);
TimeOfDay time6= TimeOfDay.fromDateTime(date6);
TimeOfDay time7= TimeOfDay.fromDateTime(date7);
TimeOfDay time8= TimeOfDay.fromDateTime(date8);
TimeOfDay time9= TimeOfDay.fromDateTime(date9);
TimeOfDay time10= TimeOfDay.fromDateTime(date10);
TimeOfDay time11= TimeOfDay.fromDateTime(date11);
TimeOfDay time12= TimeOfDay.fromDateTime(date12);
TimeOfDay time13= TimeOfDay.fromDateTime(date13);
TimeOfDay time14= TimeOfDay.fromDateTime(date14);
TimeOfDay time15= TimeOfDay.fromDateTime(date15);
TimeOfDay time16= TimeOfDay.fromDateTime(date16);
TimeOfDay time17= TimeOfDay.fromDateTime(date17);
TimeOfDay time18= TimeOfDay.fromDateTime(date18);
TimeOfDay time19= TimeOfDay.fromDateTime(date19);
TimeOfDay time20= TimeOfDay.fromDateTime(date20);
TimeOfDay time21= TimeOfDay.fromDateTime(date21);
Live live1=Live(subject: "QU’EST-CE QUE LA TOXICOMANIE ?",doctor: doctor2,date: date1,hour: time1,liveLink: "lienStreamYard",liveImage: "assets/images/toxicomanie-tof-780x405.jpg",color: Color(0xFF55CE63),);
Live live2=Live(subject: "INTOXICATION AU MONOXYDE DE CARBONE « CO »",doctor: doctor2,date: date2,hour: time2,liveLink: "lienStreamYard",liveImage: "assets/images/monoxyde-de-carbone.jpg",color: Color(0xFF009EFB),);
Live live3=Live(subject: "Les effets de l’activation physique sur les enfants",doctor: doctor2,date: date3,hour: time3,liveLink: "lienStreamYard",liveImage: "assets/images/afj.jpeg",color: Color(0xFFFFBC34),);
Live live4=Live(subject: "Alimentation de l’ado",doctor: doctor2,date: date4,hour: time4,liveLink: "lienStreamYard",liveImage: "assets/images/aa.jfif");
Live live5=Live(subject: "L’orthodontie",doctor: doctor2,date: date5,hour: time5,liveLink: "lienStreamYard",liveImage: "assets/images/o.jpg");
Live live6=Live(subject: "OBESITE",doctor: doctor2,date: date6,hour: time6,liveLink: "lienStreamYard",liveImage: "assets/images/obesite.jpg");
Live live7=Live(subject: "TABAGISME PASSIF",doctor: doctor2,date: date7,hour: time7,liveLink: "lienStreamYard",liveImage: "assets/images/Tabagisme-passif.gif");
Live live8=Live(subject: "PRESERVER VOTRE SANTE EN VOUS LAVANT LES MAINS CORRECTEMENT !",doctor: doctor2,date: date8,hour: time8,liveLink: "lienStreamYard",liveImage: "assets/images/hygiene-640x405.jpg");
Live live9=Live(subject: "COMMENT CHOISIR SON ECRAN SOLAIRE ?",doctor: doctor2,date: date9,hour: time9,liveLink: "lienStreamYard",liveImage: "assets/images/suncream-1337629_1280-1024x576.jpg");
Live live10=Live(subject: "RAMADAN « Occasion pour adopter un mode de vie sain »",doctor: doctor3,date: date10,hour: time10,liveLink: "lienStreamYard",liveImage: "assets/images/Ramadan_Reflections-780x405.jpg");
Live live11=Live(subject: "COMMENT AMÉLIORER LA QUALITÉ DE VOTRE SOMMEIL ?",doctor: doctor6,date: date11,hour: time11,liveLink: "lienStreamYard",liveImage: "assets/images/sommeil_640-640x405.jpg");
Live live12=Live(subject: "AID EL ADHA « Dangers de la dissémination du parasite responsable du kyste hydatique ! »",doctor: doctor4,date: date12,hour: time12,liveLink: "lienStreamYard",liveImage: "assets/images/kyste-hydatique-768x573.jpg");
Live live13=Live(subject: "STRESS DES EXAMENS",doctor: doctor5,date: date13,hour: time13,liveLink: "lienStreamYard",liveImage: "assets/images/STRESS-DES-EXAMENS.jpg");
Live live14=Live(subject: "PHOBIE SCOLAIRE",doctor: doctor7,date: date14,hour: time14,liveLink: "lienStreamYard",liveImage: "assets/images/School-phobie-780x405.jpg");
Live live15=Live(subject: "MOYENS POUR BOOSTER AU NATUREL SON IMMUNITE",doctor: doctor8,date: date15,hour: time15,liveLink: "lienStreamYard",liveImage: "assets/images/booster-au-naturel_640-640x405.jpg");
Live live16=Live(subject: "PELLICULES « Un problème fréquent et embarrassant ! »",doctor: doctor7,date: date16,hour: time16,liveLink: "lienStreamYard",liveImage: "assets/images/pellicule.jpg");
Live live17=Live(subject: "VÉGÉTARIEN, VÉGÉTALIEN, VÉGAN «Connaissez-vous la différence?»",doctor: doctor5,date: date17,hour: time17,liveLink: "lienStreamYard",liveImage: "assets/images/Végetarien.jpg");
Live live18=Live(subject: "BOISSONS GAZEUSES « Rafraîchissantes… mais à quel prix ! »",doctor: doctor4,date: date18,hour: time18,liveLink: "lienStreamYard",liveImage: "assets/images/Boisson-gazeuse_640.jpg");
Live live19=Live(subject: "CHOCOLAT « Ami ou ennemi de votre santé ? »",doctor: doctor6,date: date19,hour: time19,liveLink: "lienStreamYard",liveImage: "assets/images/chocolates-491165_640-640x405.jpg");
Live live20=Live(subject: "PROTÉGER SON OUÏE « c’est préserver la joie d’écouter sans risque »",doctor: doctor4,date: date20,hour: time20,liveLink: "lienStreamYard",liveImage: "assets/images/Proteger-son-ouie.jpg");
Live live21=Live(subject: "SUICIDE « Corrigeons quelques idées fausses sur le suicide »",doctor: doctor8,date: date21,hour: time21,liveLink: "lienStreamYard",liveImage: "assets/images/prévention-du-suicide-ar.png");




List<Live> thisWeekLives = [
    live1,
    live2

];
List<Live> yourLives=[
    live3,
    live4,
    live5,
    live6,
    live7,
    live8,
    live9
];
List<Live> allLives=[
  live10,
  live11,
  live12,
  live13,
  live14,
  live3,
  live4,
  live5,
  live6,
  live7,
  live8,
  live9,
  live15,
  live16,
  live17,
  live18,
  live19,
  live20,
  live21
];
