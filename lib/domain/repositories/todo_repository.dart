import 'package:taskify/core/utils/either_type_defs.dart';
import 'package:taskify/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  /// Get all todos
  ReturnFailureOr<List<TodoEntity>> getTodos();

  /// Get a specific todo by ID
  ReturnFailureOr<TodoEntity> getTodoById({required int id});

  /// Add a new todo
  ReturnFailureOr<TodoEntity> addTodo({required TodoEntity todo});

  /// Update an existing todo
  ReturnFailureOr<TodoEntity> updateTodo({required TodoEntity todo});

  /// Delete a todo by id
  ReturnFailureOr<bool> deleteTodo({required int id});

  /// Toggle todo status as completed or incompleted.
  ReturnFailureOr<TodoEntity> toggleTodoStatus({required int id});
}
