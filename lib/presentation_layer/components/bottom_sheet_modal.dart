import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

abstract class BottomSheetModal {
  static void show({
    required BuildContext context,
    required Widget content,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      builder: (_) => content,
    );
  }
}
