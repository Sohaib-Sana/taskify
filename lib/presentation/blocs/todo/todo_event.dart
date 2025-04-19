part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodosEvent extends TodoEvent {}

class GetTodoByIdEvent extends TodoEvent {
  final int id;
  const GetTodoByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String? description;
  final Priority priority;
  const AddTodoEvent({
    required this.title,
    this.description,
    required this.priority,
  });

  @override
  List<Object> get props => [title, description.toString(), priority];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;
  const UpdateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  const DeleteTodoEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ToggleTodoStatusEvent extends TodoEvent {
  final int id;
  const ToggleTodoStatusEvent({required this.id});

  @override
  List<Object> get props => [id];
}
