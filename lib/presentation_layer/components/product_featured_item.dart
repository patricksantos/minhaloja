import 'package:flutter/material.dart';

import 'package:quickfood/infra/infra.dart';

class ProductFeaturedItem extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final double price;
  final VoidCallback? onTap;
  final VoidCallback? onTapCart;

  const ProductFeaturedItem({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.price,
    required this.onTap,
    required this.onTapCart,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 140,
                    width: 130,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundImage),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                    ),
                  ),
                  Opacity(
                    opacity: .15,
                    child: Container(
                      height: 140,
                      width: 130,
                      decoration: BoxDecoration(
                        color: const Color(0xff1C1C1E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.width,
                  vertical: 8.height,
                ),
                width: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: design
                            .h6(
                              color: design.secondary100,
                            )
                            .copyWith(
                              fontSize: 14.fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'R\$${price.formatWithCurrency().trim()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: design
                              .labelS(
                                color: design.secondary200,
                              )
                              .copyWith(
                                fontSize: 12.fontSize,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 130,
            padding: EdgeInsets.only(right: 5.width, top: 5.height),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: .15,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: design.gray,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0)),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.yellowAccent,
                      size: 16.fontSize,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
