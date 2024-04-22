import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class NewDetailStore extends StatelessWidget {
  final String backgroundImage;
  final String icon;
  final String nameRestaurant;
  final String? type;
  final String description;
  final List<String> tags;
  final VoidCallback? onTapOrder;
  final VoidCallback? onTapStoreType;
  final StoreType storeType;

  const NewDetailStore({
    super.key,
    required this.backgroundImage,
    required this.icon,
    required this.nameRestaurant,
    required this.type,
    required this.description,
    required this.tags,
    required this.onTapOrder,
    required this.onTapStoreType,
    required this.storeType,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 190,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundImage),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Opacity(
                    opacity: .15,
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xff1C1C1E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(
                      top: 12.height,
                      right: 12.width,
                    ),
                    child: InkWell(
                      onTap: onTapOrder,
                      child: Container(
                        decoration: BoxDecoration(
                          color: design.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 35,
                        width: 35,
                        child: Icon(
                          Icons.receipt_rounded,
                          color: design.secondary100,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(
                      top: 12.height,
                      right: 55.width,
                    ),
                    child: InkWell(
                      onTap: onTapStoreType,
                      child: Container(
                        decoration: BoxDecoration(
                          color: design.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 35,
                        width: 35,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.width,
                            vertical: 4.height,
                          ),
                          child: Image.asset(
                            storeType == StoreType.delivery
                                ? PathImages.delivery
                                : PathImages.restaurantMenu,
                            color: design.secondary100,
                            height: 18.fontSize,
                            width: 18.fontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: design.white,
                      image: DecorationImage(
                        image: AssetImage(icon),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: design.secondary100,
                        width: 1, // 2.5
                      ),
                    ),
                  ),
                  SizedBox(width: 10.width),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: nameRestaurant,
                          style: design
                              .h5(color: design.primary100)
                              .copyWith(height: 0, fontWeight: FontWeight.w700),
                        ),
                        type != null
                            ? TextSpan(
                                text: ' ${type?.toLowerCase()}',
                                style: design
                                    .h6(color: design.secondary100)
                                    .copyWith(
                                        height: 0, fontWeight: FontWeight.w700),
                              )
                            : const TextSpan(),
                      ],
                    ),
                  ).addPadding(
                    EdgeInsets.only(
                      bottom: 15.height,
                    ),
                  ),
                ],
              ).addPadding(
                EdgeInsets.only(
                  left: 12.width,
                ),
              ),
            ],
          ),
        ),
      ],
    ).addPadding(
      EdgeInsets.only(
        top: 16.height,
        right: 16.width,
        left: 16.width,
      ),
    );
  }
}
