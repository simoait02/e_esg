class SigninModeljeune{
  final String token;

  SigninModeljeune({required this.token});
  factory SigninModeljeune.fromJson(Map<String,dynamic> jsonData){
    return SigninModeljeune(token: jsonData["access-token"]);
  }
}