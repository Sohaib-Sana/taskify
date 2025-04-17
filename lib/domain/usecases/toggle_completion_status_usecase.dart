import 'package:equatable/equatable.dart';
import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/core/utils/either_type_defs.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class ToggleCompletionStatus extends Usecase<TodoEntity, ToggleParams> {
  TodoRepository repository;
  ToggleCompletionStatus(this.repository);

  @override
  ReturnFailureOr<TodoEntity> call(ToggleParams params) async {
    return await repository.toggleTodoStatus(id: params.id);
  }
}

class ToggleParams extends Equatable {
  final int id;
  const ToggleParams(this.id);

  @override
  List<Object?> get props => [id];
}
