import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class ProductFeaturedItem extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final double price;
  final VoidCallback? onTap;

  const ProductFeaturedItem({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.price,
    required this.onTap,
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
                  // Container(
                  //   alignment: Alignment.topCenter,
                  //   height: 140,
                  //   width: 130,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(backgroundImage),
                  //       fit: BoxFit.cover,
                  //       alignment: Alignment.bottomCenter,
                  //     ),
                  //     borderRadius:
                  //         const BorderRadius.all(Radius.circular(16.0)),
                  //   ),
                  // ),
                  CachedNetworkImage(
                    imageUrl: backgroundImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.topCenter,
                      height: 140,
                      width: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                      ),
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
                  horizontal: 4.width,
                  vertical: 8.height,
                ),
                width: 130,
                height: 60.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: design
                          .labelM(
                            color: design.secondary100,
                          )
                          .copyWith(
                            fontSize: 10.fontSize,
                            fontWeight: FontWeight.w500,
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
                                fontSize: 10.fontSize,
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
