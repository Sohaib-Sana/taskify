import 'package:taskify/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required int id,
    required String title,
    required String? description,
    required bool completionStatus,
    required DateTime createdAt,
    required DateTime? completedAt,
    required Priority priority,
  }) : super(
         id: id,
         title: title,
         description: description,
         completionStatus: completionStatus,
         createdAt: createdAt,
         completedAt: completedAt,
         priority: priority,
       );

  @override
  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? completionStatus,
    DateTime? createdAt,
    DateTime? completedAt,
    Priority? priority,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completionStatus: completionStatus ?? this.completionStatus,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
    );
  }

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

  @override
  String toString() {
    return 'TodoModel(id: $id, title: $title, description: $description, completionStatus: $completionStatus, createdAt: $createdAt, completedAt: $completedAt, priority: $priority)';
  }

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.completionStatus == completionStatus &&
        other.createdAt == createdAt &&
        other.completedAt == completedAt &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        completionStatus.hashCode ^
        createdAt.hashCode ^
        completedAt.hashCode ^
        priority.hashCode;
  }
}
