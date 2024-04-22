import 'package:flutter/material.dart';
import '../../../../presentation_layer/modules/home/components/tags_restaurant.dart';

import 'package:quickfood/infra/infra.dart';

class DetailStore extends StatelessWidget {
  final String backgroundImage;
  final String icon;
  final String nameRestaurant;
  final String? type;
  final String description;
  final List<String> tags;
  final VoidCallback? onTapOrder;

  const DetailStore({
    super.key,
    required this.backgroundImage,
    required this.icon,
    required this.nameRestaurant,
    required this.type,
    required this.description,
    required this.tags,
    required this.onTapOrder,
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
          height: 180,
          child: Stack(
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
                        alignment: Alignment.bottomCenter,
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
                  onTapOrder != null
                      ? Container(
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
                        )
                      : Container(),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: design.secondary100,
                      foregroundColor: design.white,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage(icon),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 75,
                  //   alignment: Alignment.bottomRight,
                  //   child: CircleAvatar(
                  //     radius: 8,
                  //     backgroundColor: design.secondary100,
                  //     child: CircleAvatar(
                  //       radius: 6,
                  //       backgroundColor: Colors.lightBlue,
                  //       child: Icon(
                  //         Icons.check,
                  //         size: 12.fontSize,
                  //         color: design.secondary100,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 14.height),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: nameRestaurant,
                style: design
                    .h5(
                      color: design.primary100,
                    )
                    .copyWith(
                      height: 0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              type != null
                  ? TextSpan(
                      text: ' ${type!.toLowerCase()}',
                      style: design
                          .h6(
                            color: design.secondary100,
                          )
                          .copyWith(
                            height: 0,
                            fontWeight: FontWeight.w700,
                          ),
                    )
                  : const TextSpan(),
            ],
          ),
        ),
        SizedBox(height: 4.height),
        // Text(
        //   description,
        //   maxLines: 1,
        //   style: design
        //       .caption(
        //         color: design.secondary300,
        //       )
        //       .copyWith(
        //         fontWeight: FontWeight.w500,
        //       ),
        // ),
        // SizedBox(height: 10.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tags
              .map(
                (item) => TagsRestaurant(
                  tagName: item,
                ),
              )
              .toList(),
        )
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
