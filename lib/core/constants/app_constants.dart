class AppConstants {
  // App Info
  static const String appName = 'Taskify';
  static const String appVersion = '1.0.0';

  // Priority Labels
  static const Map<int, String> priorityLabels = {
    1: 'High',
    2: 'Medium',
    3: 'Low',
  };

  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 200);

  // Splash screen duration
  static const Duration splashDuration = Duration(seconds: 2);

  // Snackbar duration
  static const Duration snackBarDuration = Duration(seconds: 3);

  // Validation error messages
  static const String fieldRequired = 'This field is required';
  static const String titleTooShort = 'Title must be at least 3 characters';

  // Messages
  static const String todoAddedSuccess = 'Todo added successfully';
  static const String todoUpdatedSuccess = 'Todo updated successfully';
  static const String todoDeletedSuccess = 'Todo deleted successfully';
  static const String todoToggleSuccess = 'Todo status changed successfully';
  static const String unexpectedError = 'An unexpected error occurred';

  // Empty states
  static const String emptyTodosMessage =
      'No todos yet.\nAdd a new todo to get started!';
}
