import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_esg/api/errors/ErrorModel.dart';

class ServerException implements Exception {
  final Errormodel errormodel;

  ServerException({required this.errormodel});
}

void handleDioException(DioException e) {
  Map<String, dynamic> extractErrorData(dynamic data) {
    if (data is String) {
      try {
        return json.decode(data) as Map<String, dynamic>;
      } catch (e) {
        throw ServerException(errormodel: Errormodel(status: 500, errorMsg: data));
      }
    }
    return data as Map<String, dynamic>;
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
    case DioExceptionType.sendTimeout:
      throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
    case DioExceptionType.badCertificate:
      throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
    case DioExceptionType.cancel:
      throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
    case DioExceptionType.connectionError:
      throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
    case DioExceptionType.unknown:
      throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
        case 401:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
        case 403:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
        case 404:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
        case 409:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
        case 422:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
        case 504:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
        default:
          throw ServerException(errormodel: Errormodel.fromJson(extractErrorData(e.response!.data)));
      }
  }
}
