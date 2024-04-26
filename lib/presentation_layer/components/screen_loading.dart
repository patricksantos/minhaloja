import 'package:flutter/material.dart';
import 'package:minhaloja/infra/infra.dart';

class ScreenLoading extends StatelessWidget {
  final Color? backgroundColor;
  final Color? progressColor;
  const ScreenLoading({super.key, this.backgroundColor, this.progressColor});

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Container(
      color: backgroundColor ?? design.primary100,
      height: MediaQuery.of(context).size.height * .95 - 70,
      child: Center(
        child: CircularProgressIndicator(
          color: progressColor ?? const Color(0xffFFEFD5),
        ),
      ),
    );
  }
}
