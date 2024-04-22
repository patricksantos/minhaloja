import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class FeaturedItens extends StatelessWidget {
  final List<Widget> itens;

  const FeaturedItens({
    super.key,
    required this.itens,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Column(
      children: [
        if (itens.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.only(
              top: 24.height,
              left: 16.width,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Destaques',
                  style: design
                      .h6(
                        color: design.secondary100,
                      )
                      .copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
              top: 10.height,
              left: 16.width,
            ),
            child: Row(
              children: itens,
            ),
          ),
        ],
      ],
    );
  }
}
