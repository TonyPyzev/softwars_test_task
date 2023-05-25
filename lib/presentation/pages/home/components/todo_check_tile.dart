import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_status.dart';
import '../../../../domain/entities/task_type.dart';
import '../../../constants/app_colors.dart';
import '../../../cubit/description/description_cubit.dart';
import '../../../cubit/home/home_cubit.dart';
import '../../description/create_task_screen.dart';

class ToDoCheckTile extends StatefulWidget {
  final Task task;

  const ToDoCheckTile({
    super.key,
    required this.task,
  });

  @override
  State<ToDoCheckTile> createState() => _ToDoCheckTileState();
}

class _ToDoCheckTileState extends State<ToDoCheckTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: GestureDetector(
        onTap: () {
          context
              .read<DescriptionCubit>()
              .setEditingState(widget.task.copyWith());
          Navigator.of(context).pushNamed(DescriptionScreen.pageRoute);
        },
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          margin: const EdgeInsets.only(
            bottom: 5,
          ),
          decoration: BoxDecoration(
            color:
                widget.task.isUrgent ? AppColors.accentRed : AppColors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                widget.task.type == TaskType.work
                    ? Icons.work_outline
                    : Icons.home_outlined,
                color: AppColors.secondaryVariant,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.task.name,
                              style: const TextStyle(
                                color: AppColors.secondaryVariant,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        DateFormat('yyyy.MM.dd').format(widget.task.syncTime),
                        style: const TextStyle(
                          color: AppColors.secondaryVariant,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading) const CircularProgressIndicator(),
              if (!isLoading)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    context
                        .read<HomeCubit>()
                        .markAsCompleted(widget.task.taskId);
                  },
                  child: widget.task.status == TaskStatus.completed
                      ? Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: AppColors.disabled,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.secondaryVariant,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              color: AppColors.secondaryVariant,
                            ),
                          ),
                        )
                      : Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.secondaryVariant,
                              width: 1,
                            ),
                          ),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
