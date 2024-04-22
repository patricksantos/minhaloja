import 'package:flutter/material.dart';

import 'package:quickfood/infra/infra.dart';

class FloatingButtonCurrentPage extends StatefulWidget {
  final TabController controller;
  const FloatingButtonCurrentPage({
    super.key,
    required this.controller,
  });

  @override
  State<FloatingButtonCurrentPage> createState() =>
      _FloatingButtonCurrentPageState();
}

class _FloatingButtonCurrentPageState extends State<FloatingButtonCurrentPage> {
  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.controller.index != 0
              ? FloatingActionButton(
                  backgroundColor: design.primary200,
                  elevation: 0,
                  disabledElevation: 0,
                  onPressed: () {
                    setState(() {
                      if (widget.controller.index <=
                          widget.controller.length - 1) {
                        widget.controller.index = widget.controller.index - 1;
                      }
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 32,
                  ),
                ).addPadding(
                  EdgeInsets.only(left: 32.width),
                )
              : Container(),
          widget.controller.index != widget.controller.length - 1
              ? FloatingActionButton(
                  backgroundColor: design.primary200,
                  disabledElevation: 0,
                  onPressed: () {
                    setState(() {
                      if (widget.controller.index <
                          widget.controller.length - 1) {
                        widget.controller.index = widget.controller.index + 1;
                      }
                    });
                  },
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 32,
                  ),
                )
              : Container(),
        ],
      ).safeArea(),
    );
  }
}
