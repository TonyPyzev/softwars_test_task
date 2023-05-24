part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<Task> tasks;
  final List<Task> workTasks;
  final List<Task> personalTasks;

  const HomeState({
    this.tasks = const [],
    this.workTasks = const [],
    this.personalTasks = const [],
  });

  @override
  List<Object> get props => [
        tasks,
        workTasks,
        personalTasks,
      ];

  HomeState copyWith({
    List<Task>? tasks,
    List<Task>? workTasks,
    List<Task>? personalTasks,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      workTasks: workTasks ?? this.workTasks,
      personalTasks: personalTasks ?? this.personalTasks,
    );
  }
}
