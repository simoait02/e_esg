
import 'doctor.dart';

class Patient {
  final String id;
  final String nom;
  final String prenom;
  final String sexe;
  final int age;
  List<String> maladies;
  List<Doctor> doctors;
  final DateTime consultation_date;


  Patient(this.id,this.nom, this.prenom,this.sexe,this.age, this.consultation_date,this.maladies,this.doctors);

}