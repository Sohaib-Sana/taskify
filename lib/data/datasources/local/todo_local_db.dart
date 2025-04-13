// ignore_for_file: file_names

import 'package:taskify/data/datasources/todo_datasource.dart';
import 'package:taskify/data/models/todo_model.dart';

class TodoLocalDb implements TodoDatasource {
  @override
  Future<TodoModel> addTodo({required TodoModel todo}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTodo({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> getTodoById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<TodoModel>> getTodos() {
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> toggleTodoStatus({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> updateTodo({required TodoModel todo}) {
    throw UnimplementedError();
  }
}
