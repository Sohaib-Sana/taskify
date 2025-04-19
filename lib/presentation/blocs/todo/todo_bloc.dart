import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/domain/usecases/add_todo_usecase.dart';
import 'package:taskify/domain/usecases/get_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodosUseCase;
  final AddTodo addTodoUseCase;

  TodoBloc({required this.getTodosUseCase, required this.addTodoUseCase})
    : super(TodoInitial()) {
    on<GetTodosEvent>(_onGetTodos);
    on<AddTodoEvent>(_onAddTodo);
  }

  Future<void> _onGetTodos(GetTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final result = await getTodosUseCase(NoParams());
    result.fold(
      (failure) => emit(TodoOperationFailure(message: failure.message)),
      (todos) => emit(TodosLoaded(todos: todos)),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final result = await addTodoUseCase(
      AddTodoParams(
        todo: TodoEntity(
          title: event.title,
          description: event.description,
          createdAt: DateTime.now(),
          priority: event.priority,
        ),
      ),
    );

    result.fold(
      (failure) => emit(TodoOperationFailure(message: failure.message)),
      (todo) {
        add(GetTodosEvent());
        emit(TodoOperationSuccess(message: 'Todo added successfully'));
      },
    );
  }
}
