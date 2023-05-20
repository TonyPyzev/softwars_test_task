import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class ToDoCheckTile extends StatelessWidget {
  const ToDoCheckTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      margin: const EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.home_outlined,
            color: AppColors.secondaryVariant,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Якийсь довгий текст на сторінці у тудушичці',
                    style: TextStyle(
                      color: AppColors.secondaryVariant,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    '02.06.2023',
                    style: TextStyle(
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
          Container(
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
          ),
        ],
      ),
    );
  }
}
