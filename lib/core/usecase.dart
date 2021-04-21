import 'package:chat/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FutureUsecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUsecase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams {}
