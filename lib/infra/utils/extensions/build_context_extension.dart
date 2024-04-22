import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../presentation_layer/components/feedback_result_page.dart';

import 'package:quickfood/infra/infra.dart';

extension BuildContextExtension on BuildContext {
  void removeFocus() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  Future<String?> showSuccessFeedbackPage({
    String titleAppBar = '',
    required String title,
    required BuildContext context,
    String? message,
    String? buttonTitle,
    VoidCallback? onPressed,
    Widget? icon,
    Widget? content,
  }) {
    return showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      builder: (context) {
        return FeedbackResultPage(
          titleAppBar: titleAppBar,
          title: title,
          message: message,
          onPressed: onPressed,
          icon: icon,
          content: content,
          buttonTitle: buttonTitle,
        );
      },
    );
  }

  void showSnackBar({
    required String message,
    TextStyle? textStyle,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    TextAlign? textAlign,
    Color backgroundColor = Colors.green,
    double? height,
    bool? closeIconColor,
    String? labelAction,
    void Function()? onPressed,
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: behavior,
      closeIconColor: Colors.white,
      showCloseIcon: closeIconColor,
      action: onPressed != null
          ? SnackBarAction(
              label: labelAction ?? '',
              onPressed: onPressed,
            )
          : null,
      margin: EdgeInsets.only(
        right: 12.width,
        left: 12.width,
        bottom: height != null ? height + 10.height : 10.height,
      ),
      content: Text(
        message,
        style: textStyle,
        textAlign: textAlign,
      ),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
