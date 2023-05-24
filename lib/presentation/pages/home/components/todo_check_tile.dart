import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_status.dart';
import '../../../../domain/entities/task_type.dart';
import '../../../constants/app_colors.dart';

class ToDoCheckTile extends StatelessWidget {
  final Task task;

  const ToDoCheckTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: GestureDetector(
        onTap: () {
          //TODO navigate to task description
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
            color: task.isUrgent ? AppColors.accentRed : AppColors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                task.type == TaskType.work
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
                              task.name,
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
                        DateFormat('yyyy.MM.dd').format(task.syncTime),
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
              GestureDetector(
                onTap: () {
                  //TODO mark task completed
                },
                child: task.status == TaskStatus.completed
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
