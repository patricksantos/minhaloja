import 'package:flutter/material.dart';

class OpacityAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const OpacityAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      curve: Curves.linear,
      tween: Tween(begin: 0.0, end: 1.0),
      child: child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0, 1),
          child: child,
        );
      },
    );
  }
}
