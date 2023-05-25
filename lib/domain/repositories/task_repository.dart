import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchTasks();

  Future<List<Task>> createTask(Task task);

  Future<List<Task>> updateTask({
    required String id,
    required Map<String, dynamic> params,
  });
}
