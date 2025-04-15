import 'package:flutter/material.dart';
import 'package:taskify/core/constants/app_constants.dart';
import 'package:taskify/presentation/pages/home/widgets/add_todo_dialog.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
    final theme = Theme.of(context);
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
      body: Center(
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
      ),
    );
  }
}
