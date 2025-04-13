import 'package:fpdart/fpdart.dart';
import 'package:taskify/core/errors/failures.dart';
import 'package:taskify/core/utils/either_type_def.dart';
import 'package:taskify/data/datasources/todo_datasource.dart';
import 'package:taskify/data/models/todo_model.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoDatasource datasource;
  TodoRepositoryImpl({required this.datasource});

  @override
  ReturnFailureOr<TodoEntity> addTodo({required TodoEntity todo}) async {
    try {
      final savedTodo = await datasource.addTodo(
        todo: TodoModel.fromEntity(todo),
      );
      return Right(savedTodo);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  ReturnFailureOr<bool> deleteTodo({required int id}) async {
    try {
      bool isDeleted = await datasource.deleteTodo(id: id);
      return Right(isDeleted);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  ReturnFailureOr<TodoEntity> getTodoById({required int id}) async {
    try {
      final todoById = await datasource.getTodoById(id: id);
      return Right(todoById);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  ReturnFailureOr<List<TodoEntity>> getTodos() async {
    try {
      final todos = await datasource.getTodos();
      return Right(todos);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  ReturnFailureOr<TodoEntity> toggleTodoStatus({required int id}) async {
    try {
      final updatedTodo = await datasource.toggleTodoStatus(id: id);
      return Right(updatedTodo);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  ReturnFailureOr<TodoEntity> updateTodo({required TodoEntity todo}) async {
    try {
      final updatedTodo = await datasource.updateTodo(
        todo: TodoModel.fromEntity(todo),
      );
      return Right(updatedTodo);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
