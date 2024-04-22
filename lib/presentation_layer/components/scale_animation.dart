import 'package:flutter/material.dart';

class ScaleAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const ScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      curve: Curves.fastOutSlowIn,
      tween: Tween(begin: 0.0, end: 1.0),
      child: child,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
    );
  }
}
