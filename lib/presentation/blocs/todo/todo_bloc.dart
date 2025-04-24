import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/usecases.dart/usecase.dart';
import 'package:taskify/core/utils/priority_helper.dart';
import 'package:taskify/domain/entities/todo_entity.dart';

import '../../../core/usecases.dart/usecase_barrel.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodosUseCase;
  final AddTodo addTodoUseCase;
  final UpdateTodo updateTodoUseCase;
  final ToggleCompletionStatus toggleTodoUseCase;
  final DeleteTodo deleteTodoUseCase;

  TodoBloc({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.updateTodoUseCase,
    required this.toggleTodoUseCase,
    required this.deleteTodoUseCase,
  }) : super(const TodoInitial()) {
    on<GetTodosEvent>(_onGetTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<ToggleTodoStatusEvent>(_onToggleTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onGetTodos(GetTodosEvent event, Emitter<TodoState> emit) async {
    if ((state is TodosLoaded && (state as TodosLoaded).todos.isEmpty)) {
      emit(const TodoLoading());
    }
    final result = await getTodosUseCase(NoParams());
    result.fold(
      (failure) => emit(TodoOperationFailure(message: failure.message)),
      (todos) => emit(TodosLoaded(todos: todos)),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    // emit(const TodoLoading());
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
        add(const GetTodosEvent());
        emit(TodoOperationSuccess(message: 'Todo added successfully'));
      },
    );
  }

  Future<void> _onUpdateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    // emit(const TodoLoading());
    final result = await updateTodoUseCase(UpdateTodoParams(event.todo));
    result.fold(
      (failure) => emit(TodoOperationFailure(message: failure.message)),
      (todo) {
        add(const GetTodosEvent());
        emit(TodoOperationSuccess(message: 'Todo updated successfully.'));
      },
    );
  }

  Future<void> _onToggleTodo(
    ToggleTodoStatusEvent event,
    Emitter<TodoState> emit,
  ) async {
    // emit(const TodoLoading());
    final result = await toggleTodoUseCase(ToggleParams(event.id));
    result.fold(
      (failure) => emit(TodoOperationFailure(message: failure.message)),
      (todo) {
        add(const GetTodosEvent());
        emit(
          TodoOperationSuccess(
            message:
                todo.completionStatus
                    ? 'Todo marked as complete'
                    : 'Todo marked as incomplete',
          ),
        );
      },
    );
  }

  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    // emit(const TodoLoading());
    final result = await deleteTodoUseCase(DeleteParams(event.id));
    result.fold(
      (failure) => emit(TodoOperationFailure(message: failure.message)),
      (isDeleted) {
        if (isDeleted) {
          add(const GetTodosEvent());
          emit(TodoOperationSuccess(message: 'Todo deleted successfully.'));
        } else {
          emit(TodoOperationFailure(message: 'Failed to delete Todo'));
        }
      },
    );
  }
}
