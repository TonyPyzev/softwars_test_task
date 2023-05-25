import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class DoneButton extends StatefulWidget {
  final VoidCallback callback;

  const DoneButton({
    super.key,
    required this.callback,
  });

  @override
  State<DoneButton> createState() => _DoneButtonState();
}

class _DoneButtonState extends State<DoneButton> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLoading = true;
          });
          widget.callback();
        },
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: CircularProgressIndicator(),
              )
            : const Icon(
                Icons.done,
                size: 32,
                color: AppColors.primaryVariant,
              ),
      ),
    );
  }
}
