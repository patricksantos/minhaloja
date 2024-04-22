import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/widgets.dart';

class BottomSheetExpandable extends StatelessWidget {
  final Widget body;
  final Widget expandableContent;
  final Widget expandableHeader;

  const BottomSheetExpandable({
    super.key,
    required this.body,
    required this.expandableContent,
    required this.expandableHeader,
  });

  @override
  Widget build(BuildContext context) {
    return ExpandableBottomSheet(
      enableToggle: true,
      animationCurveExpand: Curves.decelerate,
      animationCurveContract: Curves.decelerate,
      animationDurationExtend: const Duration(milliseconds: 500),
      animationDurationContract: const Duration(milliseconds: 500),
      background: body,
      expandableContent: expandableContent,
      persistentHeader: expandableHeader,
    );
  }
}
