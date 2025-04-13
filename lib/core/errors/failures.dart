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

class LocalDatabaseFailure extends Failures {
  const LocalDatabaseFailure({required super.message});
}
