import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_status.dart';
import '../../../domain/entities/task_type.dart';
import '../../../domain/usecases/create_task.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit() : super(const CreateTaskState());

  Future<void> pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2123),
    );

    if (pickedDate != null) {
      emit(state.copyWith(
        pickedDate: pickedDate,
      ));
    }
  }

  void markAsPersonal() {
    emit(state.copyWith(
      selectedTaskType: TaskType.personal,
    ));
  }

  void markAsWork() {
    emit(state.copyWith(
      selectedTaskType: TaskType.work,
    ));
  }

  void swithUrgentState() {
    emit(state.copyWith(
      isUrgent: !state.isUrgent,
    ));
  }

  Future<List<Task>> createTask(String name, String desc) async {
    const Uuid uuid = Uuid();

    final Task task = Task(
      taskId: uuid.v4(),
      status: TaskStatus.inProgress,
      name: name,
      type: state.selectedTaskType,
      description: desc,
      fileBase64: '',
      finishDate: state.pickedDate ?? DateTime.now(),
      isUrgent: state.isUrgent,
      syncTime: DateTime.now(),
    );

    return await CreateTask().execute(task);
  }
}
