import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class NewContentItem extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String description;
  final double price;
  final VoidCallback? onTap;
  final VoidCallback? onTapCart;

  const NewContentItem({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.description,
    required this.price,
    required this.onTap,
    required this.onTapCart,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(backgroundImage),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                ),
                Opacity(
                  opacity: .15,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xff1C1C1E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
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
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                            Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: design
                                  .subtitle(
                                    color: design.secondary300,
                                  )
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'R\$${price.formatWithCurrency().trim()}',
                              style: design
                                  .subtitle(
                                    color: design.secondary300,
                                  )
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          onTapCart?.call();
                          context.showSnackBar(
                            closeIconColor: true,
                            message: 'Item adicionado ao carrinho',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: design.primary100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 25,
                          height: 25,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Icon(
                              Icons.shopping_cart_rounded,
                              color: design.white,
                              size: 16.fontSize,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ).addPadding(
                EdgeInsets.symmetric(
                  vertical: 12.height,
                  horizontal: 12.width,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
