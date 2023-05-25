import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/task_model.dart';

class TaskRemoteDataSource {
  final client = http.Client();
  late final Uri url;

  TaskRemoteDataSource({required String url}) {
    this.url = Uri.parse(url);
  }

  Future<List<TaskModel>> fetchTasks() async {
    final responce = await client.get(url);

    return _decodeResponce(responce);
  }

  Future<List<TaskModel>> createTask(TaskModel task) async {
    final responce = await client.post(
      url,
      body: task.toJson(),
    );

    return _decodeResponce(responce);
  }

  Future<List<TaskModel>> updateTask({
    required String id,
    required Map<String, dynamic> params,
  }) async {
    final responce = await client.put(
      Uri.parse('https://to-do.softwars.com.ua/tasks/$id'),
      body: json.encode(params),
    );

    return _decodeResponce(responce);
  }

  Future<List<TaskModel>> deleteTask(TaskModel task) async {
    final responce = await client.delete(
      Uri.parse('https://to-do.softwars.com.ua/tasks/${task.taskId}'),
    );

    return _decodeResponce(responce);
  }

  List<TaskModel> _decodeResponce(responce) {
    final List<TaskModel> tasks = [];

    if (responce.statusCode == 200) {
      final body = json.decode(responce.body);
      final List<dynamic> data = body['data'];

      for (var element in data) {
        tasks.add(TaskModel.fromMap(element));
      }
    }

    return tasks;
  }
}
