import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Padding addPadding(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Container addMargin(EdgeInsets margin) {
    return Container(
      margin: margin,
      child: this,
    );
  }

  Transform translate(Offset offset) {
    return Transform.translate(
      offset: offset,
      child: this,
    );
  }

  SafeArea safeArea({
    bool bottom = true,
    bool left = true,
    bool right = true,
    bool top = true,
  }) {
    return SafeArea(
      bottom: bottom,
      left: left,
      right: right,
      top: top,
      child: this,
    );
  }
}
