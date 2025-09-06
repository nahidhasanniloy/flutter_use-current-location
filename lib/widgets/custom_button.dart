import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final IconData? suffixIcon; // 👉 নতুন

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.purple,
    this.borderRadius = 10,
    this.suffixIcon, // 👉 optional
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              Icon(suffixIcon, color: Colors.white, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
