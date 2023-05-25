part of 'create_task_cubit.dart';

class CreateTaskState extends Equatable {
  final TaskType selectedTaskType;
  final DateTime? pickedDate;
  final bool isUrgent;
  final List<int> imageBytes;

  const CreateTaskState({
    this.selectedTaskType = TaskType.work,
    this.pickedDate,
    this.isUrgent = false,
    this.imageBytes = const [],
  });

  @override
  List<Object?> get props => [
        selectedTaskType,
        pickedDate,
        isUrgent,
        imageBytes,
      ];

  CreateTaskState copyWith({
    TaskType? selectedTaskType,
    DateTime? pickedDate,
    bool? isUrgent,
    List<int>? imageBytes,
  }) {
    return CreateTaskState(
      selectedTaskType: selectedTaskType ?? this.selectedTaskType,
      pickedDate: pickedDate ?? this.pickedDate,
      isUrgent: isUrgent ?? this.isUrgent,
      imageBytes: imageBytes ?? this.imageBytes,
    );
  }
}
