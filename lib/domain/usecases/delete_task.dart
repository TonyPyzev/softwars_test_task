import '../../data/repositories/task_repository_impl.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class DeleteTask {
  late final TaskRepository _taskRepository;

  DeleteTask() {
    _taskRepository = TaskRepositoryImpl();
  }

  Future<List<Task>> execute(String id) async {
    return await _taskRepository.deleteTask(id);
  }
}
