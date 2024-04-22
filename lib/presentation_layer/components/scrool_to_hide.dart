import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHide extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final double heightWidget;

  const ScrollToHide({
    super.key,
    required this.controller,
    required this.child,
    this.heightWidget = 66.0,
  });

  @override
  State<ScrollToHide> createState() => _ScrollToHideState();
}

class _ScrollToHideState extends State<ScrollToHide> {
  var _isVisible = true;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      }
      if (widget.controller.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: _isVisible ? widget.heightWidget : 0.0,
      child: widget.child,
    );
  }
}
