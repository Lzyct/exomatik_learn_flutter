import 'package:either_dart/either.dart';
import 'package:exomatik_learn_flutter/core/error/failure.dart';
import 'package:exomatik_learn_flutter/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async {
    final response = await authRemoteDataSource.login(loginParams);

    return response.fold(
      (failure) => Left(failure),
      (loginResponse) {
        return Right(loginResponse.toEntity());
      },
    );
  }
}
