import 'package:e_esg/Data/doctor_list.dart';
import 'package:e_esg/Data/live_list.dart';
import 'package:e_esg/models/patient.dart';


DateTime date1 = DateTime(2024, 1, 10);
DateTime date2 = DateTime(2023, 12, 20);
DateTime date3 = DateTime(2024, 2, 14);
DateTime date4 = DateTime(2023, 11, 30);
DateTime date5 = DateTime(2024, 3, 5);
DateTime date6 = DateTime(2023, 7, 25);
DateTime date7 = DateTime(2024, 8, 12);
DateTime date8 = DateTime(2023, 10, 18);
DateTime date9 = DateTime(2024, 4, 22);
DateTime date10 = DateTime(2023, 9, 17);
DateTime date11 = DateTime(2024, 5, 7);
DateTime date12 = DateTime(2023, 6, 29);
DateTime date13 = DateTime(2024, 1, 25);
DateTime date14 = DateTime(2023, 3, 19);
DateTime date15 = DateTime(2024, 7, 15);
DateTime date16 = DateTime(2023, 2, 9);
DateTime date17 = DateTime(2024, 12, 1);

Patient patient1=Patient("0","Sergio","Ramos","Homme",16,date1,["Fièvre"],[doctor1]);
Patient patient2=Patient("1","Chaimae","Bouti","Femme",21,date2,["Anaplasmosis","Anaplasmosis","Lupus erythemateux sytematique","oedeme","rhumotoide"],[doctor2]);
Patient patient3=Patient("2","Imane","Sehmoudi","Femme",14,date3,["rhumotoide"],[doctor1,doctor8]);
Patient patient4=Patient("3","Maha","Khourouch","Femme",16,date4,["oedeme"],[doctor3]);
Patient patient5=Patient("4","Mohammed","Ait Hssayne","Homme",20,date5,["Anaplasmosis"],[doctor4]);
Patient patient6=Patient("5","Yasmine","El mouwden","Femme",20,date6,["Fièvre","Pneumonie"],[doctor1,doctor4]);
Patient patient7=Patient("6","Jamal","lrazali","Homme",17,date7,["Fièvre","Paludisme"],[doctor6]);
Patient patient8=Patient("7","Youssef","Dissi","Homme",24,date8,["Lupus erythemateux sytematique"],[doctor7]);
Patient patient9=Patient("8","Makuto","Suzuki","Femme",15,date9,["Rage"],[doctor8]);
Patient patient10=Patient("9","Haijin","Uchiha","Homme",13,date10,["Grippe"],[doctor7,doctor4]);
Patient patient11=Patient("10","Sakura","Haruno","Femme",23,date11,["Hépatite C"],[doctor1,doctor6]);
Patient patient12=Patient("11","Toshiro","Izawaki","Homme",19,date12,["Tuberculose"],[doctor3,doctor7]);
Patient patient13=Patient("12","Jin","Lanson","Homme",22,date13,["Infection au VIH"],[doctor5]);
Patient patient14=Patient("13","Rayth","Hassan","Homme",23,date14,["Hyper tension veneuse"],[doctor6]);
Patient patient15=Patient("14","Sith","Williams","Homme",14,date15,["trichobezoard"],[doctor2]);
Patient patient16=Patient("15","Said","Mazouz","Homme",15,date16,["Fièvre"],[doctor3]);
Patient patient17=Patient("16","Aidin","Wenston","Homme",16,date17,["Oreillons"],[doctor7]);

List<Patient> patients=[
  patient1,
  patient2,
  patient3,
  patient4,
  patient5,
  patient6,
  patient7,
  patient8,
  patient9,
  patient10,
  patient11,
  patient12,
  patient13,
  patient14,
  patient15,
  patient16,
  patient17,

];