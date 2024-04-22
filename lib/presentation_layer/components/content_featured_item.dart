import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class ContentFeaturedItem extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final double price;
  final VoidCallback? onTap;
  final VoidCallback? onTapCart;

  const ContentFeaturedItem({
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
          Container(
            alignment: Alignment.topCenter,
            height: 140,
            width: 160,
            decoration: BoxDecoration(
              color: design.white,
              border: Border.all(
                color: const Color(0xffEBEDF5),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4.0),
                bottomRight: Radius.circular(4.0),
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 75,
                    width: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundImage),
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(
                  //     top: 8.height,
                  //     right: 6.width,
                  //   ),
                  //   width: 160,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           onTapCart?.call();
                  //           final snackBar = SnackBar(
                  //             behavior: SnackBarBehavior.floating,
                  //             backgroundColor: Colors.green,
                  //             margin: EdgeInsets.only(
                  //               right: 12.width,
                  //               left: 12.width,
                  //               bottom: 10.height,
                  //             ),
                  //             content: const Text(
                  //               'Item adicionado ao carrinho',
                  //             ),
                  //           );
                  //           ScaffoldMessenger.of(context)
                  //               .showSnackBar(snackBar);
                  //         },
                  //         child: CircleAvatar(
                  //           radius: 12,
                  //           backgroundColor: design.primary100,
                  //           child: Icon(
                  //             Icons.shopping_cart_rounded,
                  //             color: design.white,
                  //             size: 16.fontSize,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.width,
                  vertical: 12.height,
                ),
                // height: 65,
                width: 160,
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
                            .labelM(
                              color: design.secondary100,
                            )
                            .copyWith(
                              fontSize: 14.fontSize,
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
                                color: design.secondary300,
                              )
                              .copyWith(fontSize: 12.fontSize),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
