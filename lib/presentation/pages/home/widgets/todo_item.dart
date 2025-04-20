import 'package:flutter/material.dart';
import 'package:taskify/core/utils/priority_helper.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import '../../../../core/utils/date_formatter.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo;
  final Function(int) onToggle;
  final Function(TodoEntity) onEdit;
  final Function(int) onDelete;
  final bool animate;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priorityColor = todo.priority.toColor;
    final isCompleted = todo.completionStatus;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Dismissible(
        key: Key('todo_${todo.id}'),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onDelete(todo.id ?? 0),
        child: _buildCard(context, theme, priorityColor, isCompleted),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    ThemeData theme,
    Color priorityColor,
    bool isCompleted,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: priorityColor.withOpacity(0.5), width: 1),
      ),
      child: InkWell(
        onTap: () => onEdit(todo),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - Checkbox and priority indicator
              _buildLeftSide(context, theme, priorityColor, isCompleted),

              const SizedBox(width: 12),

              // Middle section - Title, description, and date
              Expanded(child: _buildMiddleSection(context, theme, isCompleted)),

              // Right side - Edit button
              _buildRightSide(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftSide(
    BuildContext context,
    ThemeData theme,
    Color priorityColor,
    bool isCompleted,
  ) {
    return Column(
      children: [
        // Checkbox
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: isCompleted,
            onChanged: (_) => onToggle(todo.id ?? 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: priorityColor,
          ),
        ),

        const SizedBox(height: 8),

        // Priority indicator
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: priorityColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildMiddleSection(
    BuildContext context,
    ThemeData theme,
    bool isCompleted,
  ) {
    final TextStyle titleStyle = theme.textTheme.titleMedium!.copyWith(
      decoration: isCompleted ? TextDecoration.lineThrough : null,
      color:
          isCompleted
              ? theme.textTheme.titleMedium!.color!.withOpacity(0.6)
              : null,
    );

    final TextStyle descriptionStyle = theme.textTheme.bodyMedium!.copyWith(
      decoration: isCompleted ? TextDecoration.lineThrough : null,
      color:
          isCompleted
              ? theme.textTheme.bodyMedium!.color!.withOpacity(0.6)
              : null,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          todo.title,
          style: titleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        // Description
        if (todo.description != null && todo.description!.isNotEmpty) ...[
          Text(
            todo.description!,
            style: descriptionStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
        ],

        // Date and Priority
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 14,
              color: theme.textTheme.bodySmall!.color,
            ),
            const SizedBox(width: 4),
            Text(
              DateFormatter.formatRelative(todo.createdAt),
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: todo.priority.toColor.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                todo.priority.toLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: todo.priority.toColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightSide(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit_outlined, size: 20),
      onPressed: () => onEdit(todo),
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      splashRadius: 24,
    );
  }
}
