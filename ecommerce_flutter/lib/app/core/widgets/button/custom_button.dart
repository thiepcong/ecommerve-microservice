import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.label,
    this.labelStyle,
    this.width,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final String label;
  final TextStyle? labelStyle;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(border: Border.all()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              label,
              style: labelStyle,
            )
          ],
        ),
      ),
    );
  }
}
