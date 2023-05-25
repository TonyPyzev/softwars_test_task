import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/description_screen_status.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_status.dart';
import '../../../domain/entities/task_type.dart';
import '../../../domain/usecases/create_task.dart';
import '../../../domain/usecases/delete_task.dart';

part 'description_state.dart';

class DescriptionCubit extends Cubit<DescriptionState> {
  DescriptionCubit() : super(const DescriptionState());

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
      fileBase64: base64Encode(state.imageBytes),
      finishDate: state.pickedDate ?? DateTime.now(),
      isUrgent: state.isUrgent,
      syncTime: DateTime.now(),
    );

    return await CreateTask().execute(task);
  }

  void addImage(XFile image) async {
    List<int> imageBytes = await image.readAsBytes();

    emit(state.copyWith(
      imageBytes: imageBytes,
    ));
  }

  void deleteImage() {
    emit(state.copyWith(
      imageBytes: [],
    ));
  }

  void resetState() {
    emit(const DescriptionState());
  }

  void setEditingState(Task task) {
    emit(state.copyWith(
      status: DescriptionScreenStatus.editing,
      task: task,
      selectedTaskType: task.type,
      isUrgent: task.isUrgent,
      imageBytes: base64Decode(task.fileBase64),
    ));
  }

  Future<List<Task>> updateTask(String name, String desc) async {
    final Task newTask = state.task!.copyWith(
      taskId: state.task!.taskId,
      status: state.task!.status,
      name: name,
      type: state.selectedTaskType,
      description: desc,
      fileBase64: base64Encode(state.imageBytes),
      finishDate: state.pickedDate,
      isUrgent: state.isUrgent,
      syncTime: DateTime.now(),
    );

    List<Task> fetchedTasks = await CreateTask().execute(newTask);

    return fetchedTasks;
  }

  Future<List<Task>> deleteTask() async {
    List<Task> fetchedTasks = await DeleteTask().execute(state.task!.taskId);
    return fetchedTasks;
  }
}
