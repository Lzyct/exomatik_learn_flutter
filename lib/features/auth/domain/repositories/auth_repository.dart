import 'package:either_dart/either.dart';
import 'package:exomatik_learn_flutter/core/core.dart';
import 'package:exomatik_learn_flutter/features/auth/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Login>> login(LoginParams loginParams);
}
