import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:exomatik_learn_flutter/core/core.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  late Dio _dio;

  DioClient({bool isUnitTest = false}) {
    _dio = _createDio();
  }

  Dio get dio {
    /// We need to recreate dio to avoid token issue after login
    final dio = _createDio();
    dio.interceptors.add(DioInterceptor());
    return dio;
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: "https://reqres.in",
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          validateStatus: (int? status) {
            return status! <= 500 && status != 401;
          },
        ),
      );

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioError catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['meta']['description'] as String? ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioError catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['error'] as String? ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> deleteRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.delete(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioError(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioError catch (e) {
      return Left(
        ServerFailure(
          e.response?.data?['meta']['description'] as String? ?? e.message,
        ),
      );
    }
  }
}
