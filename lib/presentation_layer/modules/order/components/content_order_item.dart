import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class ContentOrder extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String description;
  final StatusOrder status;
  final double price;
  final int quantity;
  final VoidCallback? onTap;

  const ContentOrder({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.description,
    required this.status,
    required this.price,
    required this.quantity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topCenter,
        height: 120,
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
        child: Row(
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
              ),
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
                              child: Row(
                                children: [
                                  Text(
                                    title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: design
                                        .h6(
                                          color: design.secondary100,
                                        )
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                  SizedBox(width: 2.width),
                                  Text(
                                    '(${quantity}x)',
                                    style: design
                                        .h6(
                                          color: design.secondary100,
                                        )
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            status != StatusOrder.none
                                ? getWidgetStatusOrder(design)
                                : Expanded(child: Container()),
                            Text(
                              'R\$${(price * quantity).formatWithCurrency().trim()}',
                              style: design
                                  .h6(
                                    color: design.secondary100,
                                  )
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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

  Widget getWidgetStatusOrder(FoodAppDesign design) {
    return Container(
      height: 21,
      width: 90,
      decoration: BoxDecoration(
        color:
            status == StatusOrder.emPreparo || status == StatusOrder.confirmado
                ? Colors.orange
                : status == StatusOrder.pronto
                    ? Colors.green
                    : Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        status == StatusOrder.emPreparo
            ? 'Em Praparo'
            : status == StatusOrder.pronto
                ? 'Pronto'
                : status == StatusOrder.confirmado
                    ? 'Confirmado'
                    : 'Em analise',
        style: design
            .subtitle(
              color: design.white,
            )
            .copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
