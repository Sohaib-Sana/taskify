import 'package:equatable/equatable.dart';
import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/core/utils/either_type_defs.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class GetTodo extends Usecase<List<TodoEntity>, GetTodoParams> {
  final TodoRepository repository;
  GetTodo(this.repository);

  @override
  ReturnFailureOr<List<TodoEntity>> call(GetTodoParams params) async {
    return await repository.getTodos();
  }
}

class GetTodoParams extends Equatable {
  final TodoEntity todo;
  const GetTodoParams(this.todo);

  @override
  List<Object?> get props => [todo];
}
