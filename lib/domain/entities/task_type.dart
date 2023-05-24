enum TaskType {
  personal,
  work;

  static int toIntType(TaskType type) {
    switch (type) {
      case TaskType.work:
        return 1;
      case TaskType.personal:
        return 2;
    }
  }

  static TaskType fromIntType(int status) {
    switch (status) {
      case 1:
        return TaskType.work;
      case 2:
        return TaskType.personal;
      default:
        return TaskType.personal;
    }
  }
}
