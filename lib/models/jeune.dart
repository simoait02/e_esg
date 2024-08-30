class Jeune {
  final String nom;
  final String prenom;
  final int age;
  final String sexe;
  final String numtele;

  Jeune(
    this.nom,
    this.prenom,
    this.age,
    this.sexe,
    this.numtele,
  );

  factory Jeune.fromJson(Map<String, dynamic> json) {
    return Jeune(
      json['nom'],
      json['prenom'],
      json['age'],
      json['sexe'],
      json['numtele'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'age': age,
      'sexe': sexe,
      'numtele': numtele,
    };
  }
}
