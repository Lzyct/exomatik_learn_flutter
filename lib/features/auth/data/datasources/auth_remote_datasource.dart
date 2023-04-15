import 'package:either_dart/either.dart';
import 'package:exomatik_learn_flutter/core/core.dart';
import 'package:exomatik_learn_flutter/features/auth/auth.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams loginParams) async {
    final response = await _client.postRequest(
      "/api/login",
      data: loginParams.toJson(),
      converter: (response) =>
          LoginResponse.fromJson(response as Map<String, dynamic>),
    );

    return response;
  }
}
