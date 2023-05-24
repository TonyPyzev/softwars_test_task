import '../datasources/remote/task_remote_data_source.dart';
import '../models/task_model.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  late final TaskRemoteDataSource _taskRemoteDataSource;

  TaskRepositoryImpl() {
    _taskRemoteDataSource = TaskRemoteDataSource();
  }

  @override
  Future<List<Task>> fetchTasks() async {
    final List<TaskModel> taskModels = await _taskRemoteDataSource.fetchTasks();

    return taskModels.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Task>> createTask(Task task) async {
    final List<TaskModel> taskModels =
        await _taskRemoteDataSource.createTask(task.toModel());

    return taskModels.map((e) => e.toEntity()).toList();
  }
}
