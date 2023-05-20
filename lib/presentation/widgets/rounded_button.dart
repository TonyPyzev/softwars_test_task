import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final double width;
  final Color color;
  final VoidCallback? onTap;

  const RoundedButton({
    super.key,
    required this.title,
    required this.width,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
