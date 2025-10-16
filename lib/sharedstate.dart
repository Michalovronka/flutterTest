import 'package:flutter/material.dart';
import 'package:todoapp/task.dart';

class SharedState extends InheritedWidget {
  const SharedState({
    super.key,
    required super.child,
    required this.color,
    required this.tasks,
  });

  final Color color;
  final List<Task> tasks;

  static SharedState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedState>();
  }

  static SharedState of(BuildContext context) {
    final SharedState? result = maybeOf(context);
    assert(result != null, 'No SharedState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SharedState oldWidget) =>
      color != oldWidget.color;
}
