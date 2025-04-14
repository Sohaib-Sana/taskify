import 'package:flutter/material.dart';
import 'package:taskify/core/constants/app_colors.dart';
import 'package:taskify/domain/entities/todo_entity.dart';
import 'package:taskify/presentation/widgets/custom_button.dart';
import 'package:taskify/presentation/widgets/custom_text_field.dart';
import '../../../../core/constants/app_constants.dart';

class AddTodoDialog extends StatefulWidget {
  final TodoEntity? todo;
  final Function(String, String, Priority) onAdd;
  final Function(TodoEntity) onUpdate;

  const AddTodoDialog({
    super.key,
    this.todo,
    required this.onAdd,
    required this.onUpdate,
  });

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  Priority _selectedPriority = Priority.medium; // Default to Medium

  bool get _isEditing => widget.todo != null;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.todo?.description ?? '',
    );

    if (_isEditing) {
      _selectedPriority = widget.todo!.priority;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_isEditing) {
        final updatedTodo = widget.todo!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _selectedPriority,
        );
        widget.onUpdate(updatedTodo);
      } else {
        widget.onAdd(
          _titleController.text.trim(),
          _descriptionController.text.trim(),
          _selectedPriority,
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      _isEditing ? Icons.edit : Icons.add_task,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isEditing ? 'Edit Todo' : 'Add New Todo',
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),

                const Divider(height: 24),

                // Title Field
                CustomTextField(
                  controller: _titleController,
                  label: 'Title',
                  hint: 'Enter task title',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppConstants.fieldRequired;
                    }
                    if (value.trim().length < 3) {
                      return AppConstants.titleTooShort;
                    }
                    return null;
                  },
                  autofocus: true,
                ),

                const SizedBox(height: 16),

                // Description Field
                CustomTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Enter task description (optional)',
                  isMultiline: true,
                  // maxLines: 3,
                ),

                // const SizedBox(height: 16),

                // Priority Selection
                _buildPrioritySelector(theme),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    CustomButton(
                      text: _isEditing ? 'Update' : 'Add',
                      onPressed: _handleSubmit,
                      isFullWidth: false,
                      icon: _isEditing ? Icons.save : Icons.add,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrioritySelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Priority', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildPriorityOption(
              theme,
              Priority.high,
              'High',
              AppColors.highPriorityColor,
            ),
            const SizedBox(width: 8),
            _buildPriorityOption(
              theme,
              Priority.medium,
              'Medium',
              AppColors.mediumPriorityColor,
            ),
            const SizedBox(width: 8),
            _buildPriorityOption(
              theme,
              Priority.low,
              'Low',
              AppColors.lowPriorityColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityOption(
    ThemeData theme,
    Priority priority,
    String label,
    Color color,
  ) {
    final isSelected = _selectedPriority == priority;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = priority),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
            border: Border.all(
              color: isSelected ? color : theme.dividerColor,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? color : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
