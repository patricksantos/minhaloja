import 'package:flutter/material.dart';
import 'package:minhaloja/infra/infra.dart';

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Container(
      color: design.white,
      height: MediaQuery.of(context).size.height * .95 - 70,
      child: Center(
        child: CircularProgressIndicator(
          color: design.secondary300,
        ),
      ),
    );
  }
}
