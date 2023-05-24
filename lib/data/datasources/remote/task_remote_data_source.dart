import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/task_model.dart';

class TaskRemoteDataSource {
  final client = http.Client();
  final url = Uri.parse('https://to-do.softwars.com.ua/tasks');

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
