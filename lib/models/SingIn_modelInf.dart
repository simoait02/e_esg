class SininModelinf{
  final String token;

  SininModelinf({required this.token});
  factory SininModelinf.fromJson(Map<String,dynamic> jsonData){
    return SininModelinf(token: jsonData["access-token"]);
  }
}