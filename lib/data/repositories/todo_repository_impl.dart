import 'package:taskify/core/utils/either_type_def.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  ReturnFailureOr<TodoEntity> addTodo({required TodoEntity todo}) {
    throw UnimplementedError();
  }

  @override
  ReturnFailureOr<bool> deleteTodo({required int id}) {
    throw UnimplementedError();
  }

  @override
  ReturnFailureOr<TodoEntity> getTodoById({required int id}) {
    throw UnimplementedError();
  }

  @override
  ReturnFailureOr<List<TodoEntity>> getTodos() {
    throw UnimplementedError();
  }

  @override
  ReturnFailureOr<TodoEntity> toggleTodoStatus({required int id}) {
    throw UnimplementedError();
  }

  @override
  ReturnFailureOr<TodoEntity> updateTodo({required TodoEntity todo}) {
    throw UnimplementedError();
  }
}
