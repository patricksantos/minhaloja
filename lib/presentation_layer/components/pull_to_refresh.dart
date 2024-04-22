import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class PullToRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const PullToRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return RefreshIndicator(
      onRefresh: onRefresh,
      strokeWidth: 2,
      color: design.secondary300,
      backgroundColor: design.white,
      child: child,
    );
  }
}
