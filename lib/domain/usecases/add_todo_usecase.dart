import 'package:equatable/equatable.dart';
import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/core/utils/either_type_def.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class AddTodo extends Usecase<TodoEntity, AddTodoParams> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  ReturnFailureOr<TodoEntity> call(AddTodoParams params) async {
    return await repository.addTodo(todo: params.todo);
  }
}

class AddTodoParams extends Equatable {
  final TodoEntity todo;
  const AddTodoParams({required this.todo});

  @override
  List<Object> get props => [todo];
}
