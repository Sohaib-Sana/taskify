import 'package:equatable/equatable.dart';

sealed class Failures extends Equatable {
  final String message;

  const Failures({required this.message});

  @override
  List<Object> get props => [];
}

class RemoteDatabaseFailure extends Failures {
  const RemoteDatabaseFailure({required super.message});
}

class CacheFailure extends Failures {
  const CacheFailure({required super.message});
}
