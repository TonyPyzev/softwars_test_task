import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_status.dart';
import '../../../domain/entities/task_type.dart';
import '../../../domain/usecases/fetch_tasks.dart';
import '../../../domain/usecases/update_task.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> fetchTasks() async {
    final List<Task> tasks = await FetchTasks().execute();

    tasks.sort((a, b) => b.syncTime.compareTo(a.syncTime));

    final (List<Task> workTasks, List<Task> personalTasks) =
        _sortByTaskType(tasks);

    emit(state.copyWith(
      tasks: tasks,
      workTasks: workTasks,
      personalTasks: personalTasks,
    ));
  }

  void emitTasksFromList(List<Task> tasks) {
    tasks.sort((a, b) => b.syncTime.compareTo(a.syncTime));

    final (List<Task> workTasks, List<Task> personalTasks) =
        _sortByTaskType(tasks);

    emit(state.copyWith(
      tasks: tasks,
      workTasks: workTasks,
      personalTasks: personalTasks,
    ));
  }

  void markAsCompleted(String id) async {
    final Task task = state.tasks.firstWhere((element) => element.taskId == id);

    List<Task> fetchedTasks = await UpdateTask().execute(
      id: task.taskId,
      status: {
        'status': TaskStatus.toIntType(
          task.status == TaskStatus.completed
              ? TaskStatus.inProgress
              : TaskStatus.completed,
        )
      },
    );

    emitTasksFromList(fetchedTasks);
  }

  (List<Task> workTasks, List<Task> personalTasks) _sortByTaskType(
    List<Task> tasks,
  ) {
    return (
      tasks.where((element) => element.type == TaskType.work).toList(),
      tasks.where((element) => element.type == TaskType.personal).toList(),
    );
  }
}
