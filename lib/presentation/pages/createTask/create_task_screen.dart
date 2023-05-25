import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../constants/app_colors.dart';
import '../../cubit/home/home_cubit.dart';
import 'components/form_container.dart';
import '../../theme/app_theme.dart';
import 'package:intl/intl.dart';
import '../../widgets/rounded_button.dart';
import '../../../domain/entities/task_type.dart';
import '../../cubit/createTask/create_task_cubit.dart';
import 'components/task_radio_tile.dart';

class CreateTaskScreen extends StatefulWidget {
  static const String pageRoute = '/createTask';

  final BuildContext context;

  const CreateTaskScreen({
    super.key,
    required this.context,
  });

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late final CreateTaskCubit _cubit;
  late TextEditingController _dateController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  bool isLoading = false;

  @override
  void initState() {
    _cubit = widget.context.read<CreateTaskCubit>();

    _initControllers();

    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskCubit, CreateTaskState>(
      builder: (context, state) {
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
                        _cubit.markAsWork();
                      },
                      child: TaskRadioTile(
                        title: 'Робочі',
                        isActive: state.selectedTaskType == TaskType.work
                            ? true
                            : false,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _cubit.markAsPersonal();
                      },
                      child: TaskRadioTile(
                        title: 'Особисті',
                        isActive: state.selectedTaskType == TaskType.personal
                            ? true
                            : false,
                      ),
                    ),
                  ],
                ),
              ),
              FormConatiner(
                horizontalPadding: 34,
                verticalPadding: 12,
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryVariant,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Додати запис...',
                  ),
                ),
              ),
              FormConatiner(
                horizontalPadding: 34,
                verticalPadding: 12,
                child: GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();

                    final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (image != null) {
                      _cubit.addImage(image);
                    }
                  },
                  child: state.imageBytes.isEmpty
                      ? const Text(
                          'Прикріпити файл',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryVariant,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Вкладене зображення',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryVariant,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.memory(
                                    base64Decode(
                                      base64Encode(state.imageBytes),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                GestureDetector(
                                  onTap: () {
                                    _cubit.deleteImage();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                  onTap: () {
                    _pickDate(context);
                  },
                ),
              ),
              FormConatiner(
                horizontalPadding: 34,
                verticalPadding: 12,
                child: GestureDetector(
                  onTap: () {
                    _cubit.swithUrgentState();
                  },
                  child: TaskRadioTile(
                    isActive: state.isUrgent,
                    title: 'Термінове',
                  ),
                ),
              ),
              if (!isLoading)
                RoundedButton(
                  title: 'Створити',
                  width: 170,
                  color: AppColors.primaryVariant,
                  onTap: _validateForm,
                ),
              if (isLoading) const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          context.read<CreateTaskCubit>().resetState();
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.primaryVariant,
          size: 32,
        ),
      ),
      title: SizedBox(
        width: 200,
        child: TextField(
          controller: _nameController,
          textAlign: TextAlign.center,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryVariant,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Назва завдання...',
          ),
        ),
      ),
    );
  }

  void _pickDate(BuildContext context) async {
    await _cubit.pickDate(context);

    if (_cubit.state.pickedDate != null) {
      final String formattedDate =
          'Дата завершення: ${DateFormat('dd.MM.yyyy').format(_cubit.state.pickedDate!)}';

      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  void _initControllers() {
    _dateController = TextEditingController()
      ..text = 'Дата завершення: сьогодні';
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  void _disposeControllers() {
    _dateController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  Future<void> _createTask() async {
    setState(() {
      isLoading = true;
    });

    final homeCubit = context.read<HomeCubit>();

    final tasks = await _cubit.createTask(
      _nameController.text.trim(),
      _descriptionController.text.trim(),
    );

    homeCubit.emitTasksFromList(tasks);
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.accentRed,
        content: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: AppColors.secondaryVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _validateForm() {
    if (_nameController.text.isEmpty) {
      _showSnackBar('Дайте назву завданню');
    } else {
      _createTask().then((value) => Navigator.of(context).pop());
      context.read<CreateTaskCubit>().resetState();
    }
  }
}
