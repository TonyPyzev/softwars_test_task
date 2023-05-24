import '../../data/repositories/task_repository_impl.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class FetchTasks {
  late final TaskRepository _taskRepository;

  FetchTasks() {
    _taskRepository = TaskRepositoryImpl();
  }

  Future<List<Task>> execute() async {
    return await _taskRepository.fetchTasks();
  }
}
