// API يحدد شكل التعامل مع الـ

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:e_commerce_project/core/config/env_config.dart';
// import 'package:e_commerce_project/core/di/injection_container.dart' as di;
import 'package:e_commerce_project/core/error/failures.dart';
import 'package:e_commerce_project/core/network/app_interceptors.dart';
import 'package:e_commerce_project/core/network/response_wrapper.dart';
import 'package:e_commerce_project/core/network/status_code.dart';
import 'package:e_commerce_project/core/network/status_model.dart';

import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });
}

//هو المسؤول فعليًا عن إرسال Requests للسيرفر
//+ معالجة الردود والأخطاء
class ApiClient implements ApiConsumer {
  final Dio client;
  final AppInterceptors appInterceptors; // ← add this

  ApiClient({required this.client, required this.appInterceptors}) {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
    client.interceptors.add(appInterceptors); // ← use parameter

    client.options
      ..baseUrl = EnvConfig.baseUrl
      ..responseType = ResponseType.json
      ..maxRedirects = 10
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      }
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30);

    // Add User's Interceptor
    // client.interceptors.add(di.sl<AppInterceptors>());

    // Add Pretty Dio Logger
    if (kDebugMode) {
      client.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled == true ? FormData.fromMap(body!) : body,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.patch(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.delete(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return _handleResponseAsJson(response);
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    var res = ResponseWrapper<dynamic>();

    try {
      res.statusModel = StatusModel();
      res.statusModel.code =
          response.data?["status"]?["code"] ?? response.statusCode ?? 500;
      res.statusModel.message = response.data?["status"]?["message"] ?? "";
      res.statusModel.error = response.data?["status"]?["error"] ?? 1;

      // التعامل مع error_messages
      if (response.data?["status"]?["error_messages"] != null) {
        res.statusModel.errorMessages = List<String>.from(
          response.data!["status"]["error_messages"],
        );
      } else {
        res.statusModel.errorMessages = [];
      }

      // التعامل مع data
      if ((response.statusCode == 200 ||
              response.statusCode == 201 ||
              response.statusCode == 204) &&
          response.data != null) {
        if (response.data is List) {
          res.data = response.data;
        } else if (response.data is Map<String, dynamic>) {
          // إذا موجود حقل data نستخدمه، وإلا نستخدم response نفسه
          res.data = response.data["data"] ?? response.data;
        } else {
          res.data = response.data;
        }
      } else {
        // لو response غير ناجح، نحتفظ بالبيانات للـ debug
        res.data = response.data;
      }

      return res;
    } catch (e) {
      // fallback لو صار أي خطأ
      res.statusModel = StatusModel();
      res.statusModel.code = response.statusCode ?? 500;
      res.statusModel.message = "Unknown error";
      res.statusModel.error = 1;
      res.statusModel.errorMessages = [];
      res.data = response.data;

      return res;
    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw NetworkFailure("connection time out");
      case DioExceptionType.sendTimeout:
        throw NetworkFailure("send time out");
      case DioExceptionType.receiveTimeout:
        throw NetworkFailure("receive time out");
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            // Correcting "massage" to "message" if possible, but keeping user logic
            final massage = error.response?.data["massage"];
            if (massage != null && massage.isNotEmpty) {
              throw UserFailure(massage);
            }
            throw ServerFailure("bad request");
          case StatusCode.unauthorized:
            throw AuthFailure("unauthorized");
          case StatusCode.forbidden:
            throw AuthFailure("forbidden");
          case StatusCode.notFound:
            throw ServerFailure("not found");
          case StatusCode.confilct:
            throw ServerFailure("confilct");
          case StatusCode.internalServerError:
            throw ServerFailure("internal server error");
        }
        break;
      case DioExceptionType.cancel:
        throw ServerFailure("cancel");
      case DioExceptionType.unknown:
        throw NetworkFailure("unknown");
      case DioExceptionType.badCertificate:
        throw ServerFailure("bad certificate");
      case DioExceptionType.connectionError:
        throw NetworkFailure("connection error");
    }
  }
}
