import '../../data/repositories/task_repository_impl.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask {
  late final TaskRepository _taskRepository;

  UpdateTask() {
    _taskRepository = TaskRepositoryImpl();
  }

  Future<List<Task>> execute({
    required String id,
    required Map<String, dynamic> params,
  }) async {
    return await _taskRepository.updateTask(
      id: id,
      params: params,
    );
  }
}
