import 'package:equatable/equatable.dart';

import '../../data/models/task_model.dart';
import 'task_status.dart';
import 'task_type.dart';

class Task extends Equatable {
  final String taskId;
  final TaskStatus status;
  final String name;
  final TaskType type;
  final String description;
  final String fileBase64;
  final DateTime finishDate;
  final bool isUrgent;
  final DateTime syncTime;

  const Task({
    required this.taskId,
    required this.status,
    required this.name,
    required this.type,
    required this.description,
    required this.fileBase64,
    required this.finishDate,
    required this.isUrgent,
    required this.syncTime,
  });

  @override
  List<Object> get props => [
        taskId,
        status,
        name,
        type,
        description,
        fileBase64,
        finishDate,
        isUrgent,
        syncTime,
      ];

  Task copyWith({
    String? taskId,
    TaskStatus? status,
    String? name,
    TaskType? type,
    String? description,
    String? fileBase64,
    DateTime? finishDate,
    bool? isUrgent,
    DateTime? syncTime,
  }) {
    return Task(
      taskId: taskId ?? this.taskId,
      status: status ?? this.status,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      fileBase64: fileBase64 ?? this.fileBase64,
      finishDate: finishDate ?? this.finishDate,
      isUrgent: isUrgent ?? this.isUrgent,
      syncTime: syncTime ?? this.syncTime,
    );
  }

  TaskModel toModel() {
    return TaskModel(
      taskId: taskId,
      status: status,
      name: name,
      type: type,
      description: description,
      fileBase64: fileBase64,
      finishDate: finishDate,
      isUrgent: isUrgent,
      syncTime: syncTime,
    );
  }
}
