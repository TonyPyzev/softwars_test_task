import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/task.dart';
import '../../../cubit/home/home_cubit.dart';
import 'todo_check_tile.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  const TaskListView({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<HomeCubit>().fetchTasks();
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ToDoCheckTile(
            key: UniqueKey(),
            task: tasks[index],
          );
        },
      ),
    );
  }
}
