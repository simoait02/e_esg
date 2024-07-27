import 'package:dio/dio.dart';

import 'Dio_Consumer.dart';
import 'api_Comsumer.dart';

class EndPoints{
  static String baseUrl="http://192.168.1.19:8080";
  static String LoginMedecin="/auth/login/medecins";
  static String RegisterMedecin="/register/medecins";
  static String ForgotPass="/password/forgot";
  static String ResetPass="/password/reset";
  static String RegisterInfermier="/register/professionnels";
  static String LoginInfermier="/auth/login/professionelSante";


}
class ApiKey{
  static String status="status";
  static String ErrorMsg="ErrorMessage";

}
final ApiComsumer api=DioConsumer(dio: Dio());
