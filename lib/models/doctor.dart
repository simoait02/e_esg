class Doctor {
  final String name;
  final String profil;

  Doctor(this.name,this.profil);

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      json['name'] ?? '',
      json['profil'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profil': profil,
    };
}
}