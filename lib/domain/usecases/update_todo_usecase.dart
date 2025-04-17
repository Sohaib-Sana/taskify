import 'package:equatable/equatable.dart';
import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/core/utils/either_type_defs.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class UpdateTodo extends Usecase<TodoEntity, UpdateTodoParams> {
  final TodoRepository repository;
  UpdateTodo(this.repository);
  @override
  ReturnFailureOr<TodoEntity> call(UpdateTodoParams params) async {
    return await repository.updateTodo(todo: params.todo);
  }
}

class UpdateTodoParams extends Equatable {
  final TodoEntity todo;
  const UpdateTodoParams(this.todo);
  @override
  List<Object?> get props => [todo];
}
