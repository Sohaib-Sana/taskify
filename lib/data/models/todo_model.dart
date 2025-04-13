import 'package:taskify/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.completionStatus,
    required super.createdAt,
    required super.completedAt,
    required super.priority,
  });

  factory TodoModel.fromEntity(TodoEntity todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      completionStatus: todo.completionStatus,
      createdAt: todo.createdAt,
      completedAt: todo.completedAt,
      priority: todo.priority,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completionStatus: json['completionStatus'] == 1,
      createdAt: DateTime.parse(json['createdAt']),
      completedAt:
          json['completedAt'] != null
              ? DateTime.parse(json['completedAt'])
              : null,
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completionStatus': completionStatus ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'priority': priority,
    };
  }
}
