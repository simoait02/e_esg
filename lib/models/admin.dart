import 'jeune.dart';
class Administrateur {
  final int? id;
  final Jeune? infoUser;

  Administrateur({
    this.id,
    this.infoUser,
  });

  factory Administrateur.fromJson(Map<String, dynamic> json) {
    return Administrateur(
      id: json['id'],
      infoUser: json['infoUser'] != null
          ? Jeune.fromJson(json['infoUser'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'infoUser': infoUser?.toJson(),
    };
  }
}