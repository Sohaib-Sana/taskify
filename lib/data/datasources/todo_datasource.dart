import 'package:taskify/data/models/todo_model.dart';

abstract class TodoDatasource {
  /// Get todos from Data Source
  Future<List<TodoModel>> getTodos();

  /// Get todo by specific ID from database
  Future<TodoModel> getTodoById({required int id});

  /// Add a new todo in database
  Future<TodoModel> addTodo({required TodoModel todo});

  /// Update an existing todo in database
  Future<TodoModel> updateTodo({required TodoModel todo});

  /// Delete an existing todo in database
  Future<bool> deleteTodo({required int id});

  /// Toggle todo's completion status in Database
  Future<TodoModel> toggleTodoStatus({required int id});
}
