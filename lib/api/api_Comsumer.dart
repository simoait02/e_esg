abstract class ApiComsumer{
  Future<dynamic> get(
    String path,{
    Object? data,
    Map<String,dynamic>?queryParameters, required Map<String, dynamic> headers,
  });
  post(  String path,{
    Object? data,
    Map<String,dynamic>?queryParameters, required Map<String, dynamic> headers,

  });
  patch(  String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
  });
  put(  String path,{
    Object? data,
    Map<String,dynamic>?queryParameters, required Map<String, dynamic> headers,
  });
  delete(  String path,{
    Object? data,
    Map<String,dynamic>?queryParameters,
  });

}