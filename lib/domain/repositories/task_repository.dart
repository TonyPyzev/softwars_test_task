import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchTasks();

  Future<List<Task>> createTask(Task task);
}
