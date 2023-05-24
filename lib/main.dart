import 'package:flutter/material.dart';

import 'presentation/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Application());

  // TaskRemoteDataSource().createTask(TaskModel(
  //   taskId: '213344321',
  //   status: TaskStatus.inProgress,
  //   name: 'О, працює',
  //   type: TaskType.personal,
  //   description: 'Description',
  //   fileBase64: '',
  //   finishDate: DateTime.now(),
  //   isUrgent: false,
  //   syncTime: DateTime.now(),
  // ));

  // print(
  //   await TaskRepositoryImpl().createTask(
  //     Task(
  //       taskId: '17aol34',
  //       status: TaskStatus.completed,
  //       name: 'Хто видаляє мої таски??',
  //       type: TaskType.work,
  //       description: 'Description',
  //       fileBase64: '',
  //       finishDate: DateTime.now(),
  //       isUrgent: true,
  //       syncTime: DateTime.now(),
  //     ),
  //   ),
  // );
}
