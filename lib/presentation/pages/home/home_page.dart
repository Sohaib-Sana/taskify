import 'package:flutter/material.dart';
import 'package:taskify/core/constants/app_constants.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/presentation/pages/home/widgets/add_todo_dialog.dart';
import 'package:taskify/presentation/pages/home/widgets/todo_item.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  void _loadTodos() {
    // context.read<TodoBloc>().add(const GetTodosEvent());
  }

  void _showEditTodoDialog(TodoEntity todo) {
    showDialog(
      context: context,
      builder:
          (context) => AddTodoDialog(
            todo: todo,
            onAdd: (_, __, ___) {}, // Not used here
            onUpdate: <TodoEntity>(updatedTodo) {
              Navigator.pop(context);
              // context.read<TodoBloc>().add(UpdateTodoEvent(todo: updatedTodo));
            },
          ),
    );
  }

  void _toggleTodoStatus(int id) {
    // context.read<TodoBloc>().add(ToggleTodoStatusEvent(id: id));
  }

  void _deleteTodo(int id) {
    // context.read<TodoBloc>().add(DeleteTodoEvent(id: id));
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AddTodoDialog(
            onAdd: (title, description, priority) {},
            onUpdate: (_) {}, // Not used here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.dark_mode),
            tooltip: 'Switch to dark mode',
          ),
        ],
      ),
      body: _buildEmptyState(),
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
      onRefresh: () async => _loadTodos(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return TodoItem(
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
