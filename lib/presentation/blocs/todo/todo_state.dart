part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {
  const TodoInitial();
}

final class TodoLoading extends TodoState {
  const TodoLoading();
}

final class TodosLoaded extends TodoState {
  final List<TodoEntity> todos;
  const TodosLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoOperationSuccess extends TodoState {
  final String message;

  const TodoOperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class TodoOperationFailure extends TodoState {
  final String message;

  const TodoOperationFailure({required this.message});

  @override
  List<Object> get props => [message];
}
