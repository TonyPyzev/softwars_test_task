import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

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

  Map<String, dynamic> fetchTaskDiffParams(Task comparable) {
    final Map<String, dynamic> params = <String, dynamic>{};

    if (taskId != comparable.taskId) {
      params['taskId'] = comparable.taskId;
    }
    if (status != comparable.status) {
      params['status'] = TaskStatus.toIntType(comparable.status);
    }
    if (name != comparable.name) {
      params['name'] = comparable.name;
    }
    if (type != comparable.type) {
      params['type'] = TaskType.toIntType(comparable.type);
    }
    if (description != comparable.description) {
      params['description'] = comparable.description;
    }
    if (fileBase64 != comparable.fileBase64) {
      params['file'] = comparable.fileBase64;
    }
    if (finishDate != comparable.finishDate) {
      params['finishDate'] =
          DateFormat('yyyy-MM-dd').format(comparable.finishDate);
    }
    if (isUrgent != comparable.isUrgent) {
      params['urgent'] = comparable.isUrgent ? 1 : 0;
    }
    params['syncDate'] =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    print(params);
    return params;
  }
}
