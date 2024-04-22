import 'package:flutter/material.dart';

import 'package:quickfood/infra/infra.dart';

enum AlignButton {
  left,
  right,
}

class DefaultRadioButton extends StatelessWidget {
  final String label;
  final String formValue;
  final double? width;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? height;
  final String currentValue;
  final Widget? icon;
  final void Function(String?)? onValue;
  final AlignButton alignButton;
  final Color? selectedColor;
  final Color? fillColor;
  final Color? borderColor;
  final double fontSize;
  final EdgeInsets? containerMargin;
  final BuildContext context;
  final bool border;

  const DefaultRadioButton({
    super.key,
    required this.label,
    required this.formValue,
    required this.onValue,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.icon,
    this.fontColor,
    required this.currentValue,
    this.alignButton = AlignButton.right,
    this.fillColor,
    this.selectedColor,
    this.borderColor,
    this.fontSize = 16,
    this.containerMargin,
    required this.context,
    this.border = true,
  });

  FoodAppDesign _getDesign() {
    return DesignSystem.of(context);
  }

  Color _getSelectedColor() {
    final design = _getDesign();
    return selectedColor ?? design.primary100;
  }

  Color _getBorderColor() {
    final design = _getDesign();
    return selectedColor ?? design.secondary300;
  }

  Color _getFillColor() {
    final design = _getDesign();
    return selectedColor ?? design.secondary300;
  }

  Color _getFillColors(Set<MaterialState> states) {
    return (formValue == currentValue) ? _getSelectedColor() : _getFillColor();
  }

  Expanded _buildLabel(EdgeInsets margin) {
    final design = DesignSystem.of(context);

    return Expanded(
      child: Container(
        margin: margin,
        child: Text(
          label,
          style: design.labelM(color: fontColor ?? design.secondary100),
        ),
      ),
    );
  }

  Container _buildRadio(EdgeInsets margin) {
    return Container(
      width: 20,
      height: 20,
      margin: margin,
      child: Radio(
        value: formValue,
        groupValue: currentValue,
        onChanged: onValue,
        fillColor: MaterialStateProperty.resolveWith<Color>(_getFillColors),
      ),
    );
  }

  Row _buildButton(bool hasIcon) {
    if (hasIcon && alignButton == AlignButton.right) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 16.0.width,
              top: 18.0.height,
              bottom: 18.0.height,
            ),
            child: icon,
          ),
          _buildLabel(EdgeInsets.only(left: 8.width)),
          _buildRadio(
            EdgeInsets.only(right: 18.width),
          ),
        ],
      );
    }

    if (!hasIcon && alignButton == AlignButton.left) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildRadio(EdgeInsets.only(left: 18.width, right: 0.width)),
          _buildLabel(EdgeInsets.only(left: 10.width)),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLabel(EdgeInsets.only(left: 16.width)),
        _buildRadio(EdgeInsets.only(right: 18.width)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onValue != null ? () => onValue!(formValue) : null,
      child: Container(
        margin: containerMargin,
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ?? _getDesign().white,
            borderRadius: BorderRadius.circular(8),
            border: border
                ? Border.all(
                    color: formValue == currentValue
                        ? _getSelectedColor()
                        : _getBorderColor(),
                  )
                : null,
          ),
          child: _buildButton(icon != null),
        ),
      ),
    );
  }
}
