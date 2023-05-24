import '../../data/repositories/task_repository_impl.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTask {
  late final TaskRepository _taskRepository;

  CreateTask() {
    _taskRepository = TaskRepositoryImpl();
  }

  Future<List<Task>> execute(Task task) async {
    return await _taskRepository.createTask(task);
  }
}
