import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../domain/entities/description_screen_status.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/task_type.dart';
import '../../constants/app_colors.dart';
import '../../cubit/description/description_cubit.dart';
import '../../cubit/home/home_cubit.dart';
import '../../theme/app_theme.dart';
import '../../widgets/rounded_button.dart';
import 'components/description_components.dart';

class DescriptionScreen extends StatefulWidget {
  static const String pageRoute = '/createTask';

  final BuildContext context;

  const DescriptionScreen({
    super.key,
    required this.context,
  });

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late final DescriptionCubit _cubit;
  late TextEditingController _dateController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  bool isLoading = false;

  @override
  void initState() {
    _cubit = widget.context.read<DescriptionCubit>();

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
    return BlocBuilder<DescriptionCubit, DescriptionState>(
      builder: (context, state) {
        return ScaffoldGradientBackground(
          gradient: AppTheme.scaffoldgradient,
          appBar: _appBar(context),
          body: SingleChildScrollView(
            child: Column(
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
                    textCapitalization: TextCapitalization.sentences,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxHeight: 500,
                                      ),
                                      child: Image.memory(
                                        base64Decode(
                                          base64Encode(state.imageBytes),
                                        ),
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
                    title: state.task == null ? 'Створити' : 'Видалити',
                    width: 170,
                    color: state.task == null
                        ? AppColors.primaryVariant
                        : AppColors.accentRed,
                    onTap: _validateForm,
                  ),
                if (isLoading) const CircularProgressIndicator(),
                const SizedBox(height: 150),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          context.read<DescriptionCubit>().resetState();
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
      actions: [
        if (_cubit.state.status == DescriptionScreenStatus.editing)
          DoneButton(
            callback: () async {
              if (_nameController.text.isEmpty) {
                _showSnackBar('Дайте назву завданню');
              } else {
                _updateTask().then((value) => Navigator.of(context).pop());
              }
            },
          ),
      ],
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
    if (_cubit.state.status == DescriptionScreenStatus.editing) {
      _dateController = TextEditingController()
        ..text =
            'Дата завершення: ${DateFormat('dd.MM.yyyy').format(_cubit.state.task!.finishDate)}';
      _nameController = TextEditingController()..text = _cubit.state.task!.name;
      _descriptionController = TextEditingController()
        ..text = _cubit.state.task!.description;
    } else {
      _dateController = TextEditingController()
        ..text = 'Дата завершення: сьогодні';
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
    }
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
    } else if (_nameController.text.length > 90) {
      _showSnackBar('Назва занадто велика');
    } else if (context.read<DescriptionCubit>().state.status ==
        DescriptionScreenStatus.editing) {
      _deleteTask()
          .then((value) => Navigator.of(context).pop())
          .then((value) => context.read<DescriptionCubit>().resetState());
    } else {
      _createTask()
          .then((value) => Navigator.of(context).pop())
          .then((value) => context.read<DescriptionCubit>().resetState());
    }
  }

  Future<void> _updateTask() async {
    final homeCubit = context.read<HomeCubit>();

    final List<Task> tasks = await _cubit.updateTask(
      _nameController.text.trim(),
      _descriptionController.text.trim(),
    );

    homeCubit.emitTasksFromList(tasks);
  }

  Future<void> _deleteTask() async {
    setState(() {
      isLoading = true;
    });

    final homeCubit = context.read<HomeCubit>();

    final tasks = await _cubit.deleteTask();

    homeCubit.emitTasksFromList(tasks);
  }
}
