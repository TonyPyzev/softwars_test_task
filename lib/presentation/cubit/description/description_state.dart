part of 'description_cubit.dart';

class DescriptionState extends Equatable {
  final DescriptionScreenStatus status;
  final TaskType selectedTaskType;
  final DateTime? pickedDate;
  final bool isUrgent;
  final List<int> imageBytes;
  final Task? task;

  const DescriptionState({
    this.status = DescriptionScreenStatus.creating,
    this.selectedTaskType = TaskType.work,
    this.pickedDate,
    this.isUrgent = false,
    this.imageBytes = const [],
    this.task,
  });

  @override
  List<Object?> get props => [
        status,
        selectedTaskType,
        pickedDate,
        isUrgent,
        imageBytes,
        task,
      ];

  DescriptionState copyWith({
    DescriptionScreenStatus? status,
    TaskType? selectedTaskType,
    DateTime? pickedDate,
    bool? isUrgent,
    List<int>? imageBytes,
    Task? task,
  }) {
    return DescriptionState(
      status: status ?? this.status,
      selectedTaskType: selectedTaskType ?? this.selectedTaskType,
      pickedDate: pickedDate ?? this.pickedDate,
      isUrgent: isUrgent ?? this.isUrgent,
      imageBytes: imageBytes ?? this.imageBytes,
      task: task ?? this.task,
    );
  }
}
