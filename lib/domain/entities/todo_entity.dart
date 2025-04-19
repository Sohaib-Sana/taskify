import 'package:equatable/equatable.dart';

part './sub_entities.dart';

class TodoEntity extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final bool completionStatus;
  final DateTime createdAt;
  final DateTime? completedAt;
  final Priority priority;
  const TodoEntity({
    this.id,
    required this.title,
    required this.description,
    this.completionStatus = false,
    required this.createdAt,
    this.completedAt,
    this.priority = Priority.medium,
  });

  TodoEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? completionStatus,
    DateTime? createdAt,
    DateTime? completedAt,
    Priority? priority,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completionStatus: completionStatus ?? this.completionStatus,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description.toString(),
      completionStatus,
      createdAt,
      completedAt.toString(),
      priority,
    ];
  }

  @override
  bool get stringify => true;
}
