// ignore_for_file: file_names

import 'package:sqflite/sqflite.dart' hide DatabaseException;
import 'package:path/path.dart';
import 'package:taskify/core/errors/exceptions.dart';
import 'package:taskify/data/datasources/todo_datasource.dart';
import 'package:taskify/data/models/todo_model.dart';

class TodoLocalDb implements TodoDatasource {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "todo.db"),
      onCreate: (db, version) async {
        await db.execute('''
                CREATE TABLE todos (
                  id INTEGER NOT NULL PRIMARY AUTOINCREMENT,
                  title TEXT NOT NULL,
                  description TEXT,
                  createdAt TEXT NOT NULL,
                  completionStatus INTEGER NOT NULL,
                  completedAt TEXT,
                  priority INTEGER NOT NULL,
                  isSynced INTEGER,
                )
                ''');
      },
      version: 1,
    );
  }

  @override
  Future<TodoModel> addTodo({required TodoModel todo}) async {
    try {
      final db = await database;
      final id = await db.insert('todos', todo.toJson()..remove('id'));
      return TodoModel.fromEntity(todo.copyWith(id: id));
    } catch (e) {
      throw DatabaseException('Failed to add todo: $e');
    }
  }

  @override
  Future<bool> deleteTodo({required int id}) async {
    try {
      final db = await database;
      final result = await db.delete('todos', where: 'id = ?', whereArgs: [id]);
      return result > 0;
    } catch (e) {
      throw DatabaseException('Unable to delete todo: $e');
    }
  }

  @override
  Future<TodoModel> getTodoById({required int id}) async {
    try {
      final db = await database;
      final todo = await db.query('todos', where: 'id = ?', whereArgs: [id]);
      return TodoModel.fromJson(todo.first);
    } catch (e) {
      throw DatabaseException('Failed to get todo by id $id: $e');
    }
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final db = await database;
      final List<Map<String, Object?>> todos = await db.query('todos');
      return List.generate(
        todos.length,
        (index) => TodoModel.fromJson(todos[index]),
      );
    } catch (e) {
      throw DatabaseException('Failed to get todos: $e');
    }
  }

  @override
  Future<TodoModel> toggleTodoStatus({required int id}) async {
    try {
      final db = await database;
      final todo = await getTodoById(id: id);
      final updatedTodo = TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        completionStatus: todo.completionStatus,
        createdAt: todo.createdAt,
        completedAt: todo.completedAt,
        priority: todo.priority,
      );

      await db.update(
        'todos',
        updatedTodo.toJson(),
        where: 'id = ?',
        whereArgs: [id],
      );

      return updatedTodo;
    } catch (e) {
      throw DatabaseException('Failed to toggle status of todo $id: $e');
    }
  }

  @override
  Future<TodoModel> updateTodo({required TodoModel todo}) async {
    try {
      final db = await database;
      await db.update(
        'todos',
        todo.toJson(),
        where: 'id = ?',
        whereArgs: [todo.id],
      );
      return todo;
    } catch (e) {
      throw DatabaseException('Filed to update the todo: $e');
    }
  }
}
