import 'package:flutter/material.dart';

import 'package:quickfood/infra/infra.dart';

enum AppBarIconType {
  back,
  close,
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final AppBarIconType iconType;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? titleColor;

  const DefaultAppBar({
    super.key,
    this.title,
    this.actions,
    this.onPressed,
    this.iconType = AppBarIconType.back,
    this.backgroundColor,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);

    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: backgroundColor ?? design.white,
      title: title != null
          ? Text(
              title!,
              style: design
                  .h5(color: titleColor ?? design.secondary100)
                  .copyWith(fontWeight: FontWeight.w700),
            )
          : null,
      actions: [
        if (actions != null) ...actions!,
        SizedBox(
          width: 36.width,
        )
      ],
      leading: Padding(
        padding: EdgeInsets.only(left: 27.0.width),
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: iconType == AppBarIconType.back
              ? Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: iconColor ?? design.secondary100,
                )
              : Icon(
                  Icons.close,
                  size: 18.0.fontSize,
                  color: design.secondary100,
                ),
          onPressed: onPressed ?? Navigator.of(context).pop,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
