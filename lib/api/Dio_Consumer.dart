import 'package:dio/dio.dart';
import 'package:e_esg/api/api_Comsumer.dart';
import 'package:e_esg/api/api_interceptors.dart';
import 'package:e_esg/api/end_points.dart';
import 'package:e_esg/api/errors/Exceptions.dart';

class DioConsumer extends ApiComsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  get(String path, {Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }



  @override
  patch(String path, {Object? data, Map<String, dynamic>? queryParameters,required Map<String, dynamic> headers}) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  post(String path, {Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  put(String path, {Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
