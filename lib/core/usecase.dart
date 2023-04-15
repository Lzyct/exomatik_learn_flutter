import 'package:either_dart/either.dart';
import 'package:exomatik_learn_flutter/core/core.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Class to handle when useCase don't need params
class NoParams {}
