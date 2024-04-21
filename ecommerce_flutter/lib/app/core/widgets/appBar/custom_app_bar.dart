import 'package:auto_route/auto_route.dart';
import 'package:ecommerce_flutter/app/main_router.dart';
import 'package:flutter/material.dart';

import '../../values/app_colors.dart';
import '../../values/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.bgColor = AppColors.colorFFf7472f,
    required this.label,
    this.style,
    this.actions,
    this.isLeading = true,
    this.isBack = false,
  });

  final Color bgColor;
  final String label;
  final TextStyle? style;
  final List<Widget>? actions;
  final bool isLeading;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 140,
      leading: isLeading
          ? Center(
              child: Row(
                children: [
                  if (isBack)
                    IconButton(
                      onPressed: () => context.router.pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.colorFFFFFFFF,
                      ),
                    ),
                  TextButton(
                    onPressed: () => context.router.pushAndPopUntil(
                      const HomeViewRoute(),
                      predicate: (_) => false,
                    ),
                    child: Text(
                      "Thiep's Shop",
                      style: TextStyles.boldWhiteS20.copyWith(
                          color: AppColors.colorFF9BD7FF, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: bgColor,
      title: Text(
        label,
        style: style ?? TextStyles.boldWhiteS20,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
