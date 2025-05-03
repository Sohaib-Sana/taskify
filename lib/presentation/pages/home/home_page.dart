import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/config/themes/cubit/theme_cubit.dart';
import 'package:taskify/core/constants/app_constants.dart';
import 'package:taskify/core/utils/global_keys.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/presentation/blocs/todo/todo_bloc.dart';
import 'package:taskify/presentation/pages/home/widgets/add_todo_dialog.dart';
import 'package:taskify/presentation/pages/home/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _loadTodos();
    super.initState();
  }

  void _loadTodos() {
    context.read<TodoBloc>().add(const GetTodosEvent());
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AddTodoDialog(
            onAdd: (title, description, priority) {
              context.read<TodoBloc>().add(
                AddTodoEvent(
                  title: title,
                  description: description,
                  priority: priority,
                ),
              );
            },
          ),
    );
  }

  void _showEditTodoDialog(TodoEntity todo) {
    showDialog(
      context: context,
      builder:
          (context) => AddTodoDialog(
            todo: todo,
            onUpdate: <TodoEntity>(updatedTodo) {
              context.read<TodoBloc>().add(UpdateTodoEvent(todo: updatedTodo));
            },
          ),
    );
  }

  void _toggleTodoStatus(int id) {
    context.read<TodoBloc>().add(ToggleTodoStatusEvent(id: id));
  }

  void _deleteTodo(int id) {
    context.read<TodoBloc>().add(DeleteTodoEvent(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppConstants.appName),
        actions: [
          IconButton(
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            icon: Icon(Icons.dark_mode),
            tooltip: 'Switch to dark mode',
          ),
        ],
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoLoading) {
            refreshIndicatorKey.currentState?.show();
          } else if (state is TodoOperationSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  duration: AppConstants.snackBarDuration,
                ),
              );
          } else if (state is TodoOperationFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  duration: AppConstants.snackBarDuration,
                ),
              );
          }
        },
        builder: (context, state) {
          if ((state is TodoInitial ||
                  state is TodoLoading ||
                  state is TodoOperationSuccess) &&
              state is! TodosLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if ((state is TodosLoaded && state.todos.isEmpty)) {
            return _buildEmptyState();
          } else if (state is TodoOperationFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            });
            return _buildEmptyState();
          } else {
            return _buildTodoList((state as TodosLoaded).todos);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        tooltip: 'Add new TODO',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 18,
        children: [
          Icon(Icons.task_alt),
          // SizedBox(height: 18),
          Text(
            AppConstants.emptyTodosMessage,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.textTheme.bodyLarge!.color!.withAlpha(
                (0.75 * 255).toInt(),
              ),
            ),
            textAlign: TextAlign.center,
          ),
          // SizedBox(height: 18),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddTodoDialog();
            },
            label: Text('Add Your First Todo'),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(List<TodoEntity> todos) {
    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: () async => _loadTodos(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoItem(
            key: ValueKey(todos[index]),
            todo: todos[index],
            onToggle: _toggleTodoStatus,
            onEdit: _showEditTodoDialog,
            onDelete: _deleteTodo,
          );
        },
      ),
    );
  }
}
