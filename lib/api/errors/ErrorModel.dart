import 'package:e_esg/api/end_points.dart';

class Errormodel{
  final int status;
  final String errorMsg;

  Errormodel({required this.status, required this.errorMsg});
  factory Errormodel.fromJson(Map<String,dynamic> jsonData){
    return Errormodel(status: jsonData[ApiKey.status], errorMsg: jsonData[ApiKey.ErrorMsg]);
  }
}