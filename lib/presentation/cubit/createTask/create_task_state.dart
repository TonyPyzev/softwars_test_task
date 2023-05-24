part of 'create_task_cubit.dart';

class CreateTaskState extends Equatable {
  final TaskType selectedTaskType;
  final DateTime? pickedDate;
  final bool isUrgent;

  const CreateTaskState({
    this.selectedTaskType = TaskType.work,
    this.pickedDate,
    this.isUrgent = false,
  });

  @override
  List<Object?> get props => [
        selectedTaskType,
        pickedDate,
        isUrgent,
      ];

  CreateTaskState copyWith({
    TaskType? selectedTaskType,
    DateTime? pickedDate,
    bool? isUrgent,
  }) {
    return CreateTaskState(
      selectedTaskType: selectedTaskType ?? this.selectedTaskType,
      pickedDate: pickedDate ?? this.pickedDate,
      isUrgent: isUrgent ?? this.isUrgent,
    );
  }
}
