import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:minhaloja/infra/infra.dart';

class NewDetailStore extends StatefulWidget {
  final List<String> backgroundImage;
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
  State<NewDetailStore> createState() => _NewDetailStoreState();
}

class _NewDetailStoreState extends State<NewDetailStore> {
  late CarouselController _carouselController;
  var _current = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 230,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Stack(
                children: [
                  // SizedBox(
                  //   height: 140,
                  //   child: CachedNetworkImage(
                  //     imageUrl: widget.backgroundImage.first,
                  //     imageBuilder: (context, imageProvider) => Container(
                  //       alignment: Alignment.center,
                  //       height: 140,
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: imageProvider,
                  //           fit: BoxFit.cover,
                  //           alignment: Alignment.center,
                  //         ),
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          aspectRatio: 2.0,
                          enableInfiniteScroll: true,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                          height: 180,
                          viewportFraction: 1.0,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: widget.backgroundImage
                            .map(
                              (item) => CachedNetworkImage(
                                imageUrl: widget.backgroundImage.first,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  alignment: Alignment.center,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Positioned(
                        bottom: 5.height,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.backgroundImage.asMap().entries.map(
                            (entry) {
                              return GestureDetector(
                                onTap: () => _carouselController
                                    .animateToPage(entry.key),
                                child: Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 8.0.height,
                                    horizontal: 4.0.width,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == entry.key
                                        ? design.primary200
                                        : design.secondary300.withOpacity(0.5),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: .15,
                    child: Container(
                      height: 180,
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
                      onTap: widget.onTapOrder,
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
                      onTap: widget.onTapStoreType,
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
                            widget.storeType == StoreType.delivery
                                ? PathImages.fastDelivery
                                : PathImages.localizacao,
                            color: design.secondary100,
                            height: 14.fontSize,
                            width: 14.fontSize,
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
                  // Container(
                  //   alignment: Alignment.bottomCenter,
                  //   height: 90,
                  //   width: 90,
                  //   decoration: BoxDecoration(
                  //     color: design.white,
                  //     image: DecorationImage(
                  //       image: AssetImage(icon),
                  //       fit: BoxFit.cover,
                  //       alignment: Alignment.topCenter, //center
                  //     ),
                  //     borderRadius: BorderRadius.circular(20),
                  //     border: Border.all(
                  //       color: design.secondary100,
                  //       width: 1, // 2.5
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: CachedNetworkImage(
                      imageUrl: widget.icon,
                      imageBuilder: (context, imageProvider) => Container(
                        alignment: Alignment.bottomCenter,
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: design.white,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: design.gray,
                            width: 1, // 2.5
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10.width),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.nameRestaurant,
                          style: GoogleFonts.yesevaOne(
                            textStyle: TextStyle(
                              height: 0,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w700,
                              color: design.primary100,
                            ),
                          ),
                        ),
                        widget.type != null
                            ? TextSpan(
                                text: ' ${widget.type?.toLowerCase()}',
                                style: design
                                    .h6(color: design.secondary100)
                                    .copyWith(
                                      fontSize: 14.0,
                                      height: 0,
                                      fontWeight: FontWeight.w700,
                                    ),
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
