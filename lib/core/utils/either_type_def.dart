import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/errors/failures.dart';

typedef ReturnEither<T> = Future<Either<Failures, T>>;
