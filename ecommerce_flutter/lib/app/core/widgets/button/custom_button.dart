import 'package:flutter/material.dart';

import '../../values/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.icon,
    required this.label,
    this.labelStyle,
    this.width,
    this.iconColor,
    this.borderColor,
    this.backgroundColor,
  });

  final VoidCallback? onTap;
  final IconData? icon;
  final Color? iconColor;
  final Color? borderColor;
  final Color? backgroundColor;
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
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? AppColors.colorFF000000),
            color: backgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: iconColor,
                  )
                : const SizedBox.shrink(),
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
