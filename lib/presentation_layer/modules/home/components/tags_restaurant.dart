import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class TagsRestaurant extends StatelessWidget {
  final String tagName;
  const TagsRestaurant({
    super.key,
    required this.tagName,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: design.primary200,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 3.height,
        ),
        child: Text(
          tagName,
          style: design
              .caption(
                color: design.white,
              )
              .copyWith(
                fontSize: 10.fontSize,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
