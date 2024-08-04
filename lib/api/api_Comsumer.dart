abstract class ApiComsumer{
  Future<dynamic> get(
    String path,{
    Object? data,
    Map<String,dynamic>?queryParameters, required Map<String, dynamic> headers,
  });
  post(  String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
  });
  patch(  String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
  });
  delete(  String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
  });

}