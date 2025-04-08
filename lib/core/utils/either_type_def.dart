import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/errors/failures.dart';

typedef ReturnFailureOr<T> = Future<Either<Failures, T>>;
