import 'package:flutter/material.dart';

class SliverFlexibleScroll extends StatelessWidget {
  final Widget child;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  const SliverFlexibleScroll({
    super.key,
    required this.child,
    this.physics,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: physics,
      controller: controller,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        )
      ],
    );
  }
}
