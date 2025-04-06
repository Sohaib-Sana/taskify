import 'package:equatable/equatable.dart';
import 'package:taskify/core/utils/either_type_def.dart';

abstract class Usecase<Type, Params> {
  ReturnFailureOr<Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
