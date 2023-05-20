import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:softwars_test_task/presentation/constants/app_colors.dart';
import 'package:softwars_test_task/presentation/pages/createTask/components/form_container.dart';
import 'package:softwars_test_task/presentation/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:softwars_test_task/presentation/widgets/rounded_button.dart';

import 'components/task_radio_tile.dart';

enum TaskType {
  personal,
  work,
}

class CreateTaskScreen extends StatefulWidget {
  static const String pageRoute = '/createTask';

  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late TaskType _selectedTaskType;
  late TextEditingController _dateController;
  DateTime? _pickedDate;
  bool _isUrgent = false;

  @override
  void initState() {
    _selectedTaskType = TaskType.work;
    _dateController = TextEditingController()..text = 'Дата завершення:';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppTheme.scaffoldgradient,
      appBar: _appBar(context),
      body: Column(
        children: [
          FormConatiner(
            verticalPadding: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTaskType = TaskType.work;
                    });
                  },
                  child: TaskRadioTile(
                    title: 'Робочі',
                    isActive: _selectedTaskType == TaskType.work ? true : false,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTaskType = TaskType.personal;
                    });
                  },
                  child: TaskRadioTile(
                    title: 'Особисті',
                    isActive:
                        _selectedTaskType == TaskType.personal ? true : false,
                  ),
                ),
              ],
            ),
          ),
          const FormConatiner(
            horizontalPadding: 34,
            verticalPadding: 12,
            child: TextField(
              maxLines: 3,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryVariant,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Додати запис...',
              ),
            ),
          ),
          FormConatiner(
            horizontalPadding: 34,
            verticalPadding: 12,
            child: GestureDetector(
              onTap: () {
                //TODO attach image
              },
              child: const Text(
                'Прикріпити файл',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryVariant,
                ),
              ),
            ),
          ),
          FormConatiner(
            horizontalPadding: 34,
            child: TextField(
              controller: _dateController,
              readOnly: true,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryVariant,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              onTap: _pickDate,
            ),
          ),
          FormConatiner(
            horizontalPadding: 34,
            verticalPadding: 12,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isUrgent = !_isUrgent;
                });
              },
              child: TaskRadioTile(
                isActive: _isUrgent,
                title: 'Термінове',
              ),
            ),
          ),
          RoundedButton(
            title: 'Створити',
            width: 170,
            color: AppColors.primaryVariant,
            onTap: () {
              // TODO create task
            },
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          //TODO navigate back
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.primaryVariant,
          size: 32,
        ),
      ),
      title: const SizedBox(
        width: 200,
        child: TextField(
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.sentences,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryVariant,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Назва завдання...',
          ),
        ),
      ),
    );
  }

  void _pickDate() async {
    _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2123),
    );

    if (_pickedDate != null) {
      final String formattedDate =
          DateFormat('dd.MM.yyyy').format(_pickedDate!);

      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }
}
