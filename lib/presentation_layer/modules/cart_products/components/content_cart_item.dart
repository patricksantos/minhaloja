import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minhaloja/domain_layer/entities.dart';
import '../../../../presentation_layer/components/counter_view.dart';

import 'package:minhaloja/infra/infra.dart';

class ContentCartItem extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String? note;
  final double price;
  final int quantity;
  final ComboEntity? combo;
  final VoidCallback? onTap;
  final VoidCallback? onTapRemoveItem;
  final dynamic Function(int)? counterCallback;

  const ContentCartItem({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.note,
    required this.combo,
    required this.price,
    required this.quantity,
    required this.onTap,
    required this.onTapRemoveItem,
    this.counterCallback,
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
            constraints: const BoxConstraints(minHeight: 174),
            decoration: BoxDecoration(
              color: design.white,
              border: Border.all(
                color: const Color(0xffEBEDF5),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  // Container(
                  //   alignment: Alignment.bottomCenter,
                  //   height: 174,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(backgroundImage),
                  //       fit: BoxFit.cover,
                  //       alignment: Alignment.center,
                  //     ),
                  //     borderRadius: BorderRadius.circular(12.0),
                  //   ),
                  // ),
                  CachedNetworkImage(
                    imageUrl: backgroundImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.bottomCenter,
                      height: 174,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 12.height,
                      left: 10.width,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.width),
                          decoration: BoxDecoration(
                            color: const Color(0xff1F8B51).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: const BoxConstraints(minWidth: 90),
                          alignment: Alignment.center,
                          height: 35,
                          child: Text(
                            'R\$ ${combo?.value ?? price.formatWithCurrency().trim()}',
                            style: design
                                .labelM(
                                  color: design.white,
                                )
                                .copyWith(
                                  fontSize: 14.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 174,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 19.width,
                vertical: 10.height,
              ),
              decoration: BoxDecoration(
                color: design.secondary100.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: note != null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
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
                                  color: design.white,
                                )
                                .copyWith(
                                  fontSize: 16.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        // note != null
                        //     ? Text(
                        //         note ?? '',
                        //         maxLines: 1,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: design
                        //             .labelS(
                        //               color: design.white.withOpacity(0.7),
                        //             )
                        //             .copyWith(
                        //               fontSize: 14.fontSize,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //       )
                        //     : Container(),
                        combo != null
                            ? Text(
                                'Tamanho: ${combo!.name.toUpperCase()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: design
                                    .labelS(
                                      color: design.white.withOpacity(0.7),
                                    )
                                    .copyWith(
                                      fontSize: 14.fontSize,
                                      fontWeight: FontWeight.w500,
                                    ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 41,
                        child: CounterView(
                          counterCallback: (value) {
                            counterCallback?.call(value);
                          },
                          minNumber: 0,
                          initNumber: quantity,
                          color: design.white.withOpacity(0.5),
                          colorText: design.secondary100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
