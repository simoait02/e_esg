class SigninModeldoc{
  final String token;

  SigninModeldoc({required this.token});
  factory SigninModeldoc.fromJson(Map<String,dynamic> jsonData){
    return SigninModeldoc(token: jsonData["access-token"]);
  }
}