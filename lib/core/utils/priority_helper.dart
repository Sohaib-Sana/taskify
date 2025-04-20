import 'package:flutter/material.dart';
import 'package:taskify/core/constants/app_colors.dart';

enum Priority { low, medium, high }

extension PriorityExt on Priority {
  int get toInt => switch (this) {
    Priority.low => 2,
    Priority.medium => 1,
    Priority.high => 0,
  };

  Color get toColor => switch (this) {
    Priority.low => AppColors.lowPriorityColor,
    Priority.medium => AppColors.mediumPriorityColor,
    Priority.high => AppColors.highPriorityColor,
  };
  String get toLabel => switch (this) {
    Priority.low => 'Low',
    Priority.medium => 'Medium',
    Priority.high => 'High',
  };
}

extension IntToPriority on int {
  Priority get toPriority => switch (this) {
    2 => Priority.low,
    1 => Priority.medium,
    0 => Priority.high,
    _ => Priority.medium,
  };
}
