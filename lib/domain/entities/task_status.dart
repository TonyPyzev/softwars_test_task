enum TaskStatus {
  inProgress,
  completed;

  static int toIntType(TaskStatus status) {
    switch (status) {
      case TaskStatus.inProgress:
        return 1;
      case TaskStatus.completed:
        return 2;
    }
  }

  static TaskStatus fromIntType(int status) {
    switch (status) {
      case 1:
        return TaskStatus.inProgress;
      case 2:
        return TaskStatus.completed;
      default:
        return TaskStatus.inProgress;
    }
  }
}
