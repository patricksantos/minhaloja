import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class DefaultButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? primaryColor;
  final Color? colorLoading;
  final TextStyle? labelStyle;
  final bool disable;
  final bool loading;
  final bool enablePressOnLoading;

  const DefaultButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.primaryColor,
    this.colorLoading,
    this.labelStyle,
    this.disable = false,
    this.loading = false,
    this.enablePressOnLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return ElevatedButton(
      onPressed: !disable ? _onPress : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.maxFinite, 56.0),
        elevation: 0,
        backgroundColor: primaryColor ?? design.primary100,
        disabledBackgroundColor: design.primary100.withOpacity(.8),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Visibility(
        replacement: SizedBox(
          child: CircularProgressIndicator(
            color: colorLoading ?? design.primary100,
          ),
        ),
        visible: !loading,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: labelStyle ??
                design
                    .labelM(color: design.white)
                    .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  void _onPress() {
    if (!loading || enablePressOnLoading) {
      onPressed?.call();
    }
  }
}
