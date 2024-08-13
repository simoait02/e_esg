import 'package:dio/dio.dart';

import 'Dio_Consumer.dart';
import 'api_Comsumer.dart';

class EndPoints{
  static String baseUrl="http://192.168.1.2:8080";
  static String LoginMedecin="/auth/login/medecins";
  static String RegisterMedecin="/register/medecins";
  static String ForgotPass="/password/forgot";
  static String ResetPass="/password/reset";
  static String RegisterInfermier="/register/professionnels";
  static String LoginInfermier="/auth/login/professionelSante";
  static String LoginJeune="/auth/login/jeunes";
  static String RegisterJeuneScola="/register/jeunes/scolarise";
  static String RegisterJeuneUnScola="/register/jeunes/nonscolarise";
  static String GetJeuneViaId="/jeunes/";
  static String GetAllMedecins="/medecins";
  static String CreateDiscussion="/discussion";
  static String GetInvitation="/invitation/all";
  static String GetDiscussionViaId="/discussion";
  static String GetAllDiscussion="/discussion/all";
  static String GetPatientsByPrenom="/jeunes/order-by-prenom";
  static String GetPatientsByNom="/jeunes/order-by-nom";
  static String GetPatientsByAge="/jeunes/order-by-age-asc";
  static String PostConsultation="/consultations";
  static String GetInfermierviaId="/professionnels";

}
class ApiKey{
  static String status="status";
  static String ErrorMsg="ErrorMessage";

}
final ApiComsumer api=DioConsumer(dio: Dio());
