import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/task_status.dart';
import '../../domain/entities/task_type.dart';

class TaskModel extends Equatable {
  final String taskId;
  final TaskStatus status;
  final String name;
  final TaskType type;
  final String description;
  final String fileBase64;
  final DateTime finishDate;
  final bool isUrgent;
  final DateTime syncTime;

  const TaskModel({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'status': TaskStatus.toIntType(status),
      'name': name,
      'type': TaskType.toIntType(type),
      'description': description,
      'file': fileBase64,
      'finishDate': DateFormat('yyyy-MM-dd').format(finishDate),
      'urgent': isUrgent ? 1 : 0,
      'syncDate': DateFormat('yyyy-MM-dd HH:mm:ss').format(syncTime),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'] as String,
      status: TaskStatus.fromIntType(map['status']),
      name: map['name'] as String,
      type: TaskType.fromIntType(map['type']),
      description: map['description'] as String,
      fileBase64: map['file'] as String,
      finishDate: DateTime.parse(map['finishDate'] as String),
      isUrgent: map['urgent'] == 1 ? true : false,
      syncTime: DateTime.parse(map['syncTime']),
    );
  }

  String toJson() => '[${json.encode(toMap())}]';

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Task toEntity() {
    return Task(
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
