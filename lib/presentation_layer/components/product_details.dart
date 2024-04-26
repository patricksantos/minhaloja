import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../presentation_layer/components/default_button.dart';
import '../../presentation_layer/components/counter_view.dart';
import '../../presentation_layer/components/text_input_default.dart';

import 'package:minhaloja/data_layer/data_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class ProductDetails extends StatefulWidget {
  final ProductDTO product;

  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late CartCubit _cartCubit;

  late CarouselController _carouselController;
  late TextEditingController _textEditingController;

  var visibleText = false;
  var popModal = true;
  var _current = 0;
  var _quantityProduct = 1;

  // _scrollListener() {
  //   if (_controller.offset.height >= 215) {
  //     setState(() {
  //       visibleText = true;
  //     });
  //   } else {
  //     setState(() {
  //       visibleText = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _cartCubit = Modular.get<CartCubit>();
    _cartCubit.getListCartStorage();
    
    _carouselController = CarouselController();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Material(
      color: design.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .95,
        child: CustomScrollView(
          primary: false,
          controller: ModalScrollController.of(context),
          slivers: [
            SliverAppBar(
              pinned: true,
              toolbarHeight: 60,
              expandedHeight: 500,
              backgroundColor: Colors.transparent,
              title: visibleText
                  ? Text(
                      widget.product.name.toCapitalized(),
                      style: design
                          .h5(color: design.white)
                          .copyWith(fontWeight: FontWeight.w700),
                    )
                  : null,
              leading: Container(
                padding: EdgeInsets.only(
                  left: 12.width,
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: Modular.to.pop,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            const Color(0x0febedf5).withOpacity(.22),
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.height),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: design.white,
                              textDirection: TextDirection.rtl,
                              size: 26.fontSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flexibleSpace: SizedBox(
                height: 500,
                child: Stack(
                  children: [
                    CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enableInfiniteScroll: false,
                        scrollDirection: Axis.horizontal,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 5),
                        height: 500,
                        viewportFraction: 1.0,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: widget.product.image
                          .map(
                            (item) => CachedNetworkImage(
                              imageUrl: item,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.grey,
                              ),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                alignment: Alignment.topCenter,
                                height: 500,
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
                          )
                          .toList(),
                    ),
                    Visibility(
                      visible: !visibleText,
                      child: Positioned(
                        bottom: 5.height,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              widget.product.image.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () =>
                                  _carouselController.animateToPage(entry.key),
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
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              fillOverscroll: false,
              hasScrollBody: false,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name.toCapitalized(),
                        style: design
                            .h4(
                              color: design.secondary100,
                            )
                            .copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(height: 8.height),
                      Text(
                        widget.product.description,
                        style: design.paragraphS(
                          color: design.secondary300,
                        ),
                      ),
                      SizedBox(height: 15.height),
                      Text('Alguma observação?',
                          style: design.paragraphS(
                            color: const Color(0xff67676D),
                          )),
                      SizedBox(height: 8.height),
                      TextInputDefault(
                        context: context,
                        controller: _textEditingController,
                        hintText: 'Escreva uma nota para a loja',
                        enable: true,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.height),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            (MediaQuery.of(context).size.width - 50.width)
                                    .width ~/
                                (8 + 3).width,
                            (_) => Container(
                              width: 8,
                              height: 1.5,
                              color: const Color(0xff939393),
                              margin: EdgeInsets.symmetric(
                                  horizontal: (3 / 2).width),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Total',
                            style: design
                                .h5(
                                  color: design.secondary100,
                                )
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$${(widget.product.value * _quantityProduct).formatWithCurrency().trim()}',
                            style: design
                                .h5(
                                  color: design.secondary100,
                                )
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 17.height),
                      SizedBox(
                        height: 51,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 124,
                              child: CounterView(
                                counterCallback: (value) {
                                  setState(() {
                                    _quantityProduct = value;
                                  });
                                },
                                minNumber: 1,
                                initNumber: 1,
                              ),
                            ),
                            SizedBox(width: 12.width),
                            Expanded(
                              flex: 1,
                              child: DefaultButton(
                                label: 'Adicionar',
                                onPressed: () {
                                  List<ProductDTO> list = [];
                                  while (_quantityProduct != 0) {
                                    list.add(widget.product.copyWith(
                                      id: widget.product.id,
                                      note: _textEditingController.text != ''
                                          ? _textEditingController.text
                                          : null,
                                    ));
                                    _quantityProduct--;
                                  }
                                  _cartCubit.addAllCartProducts(
                                    products: list,
                                  );
                                  Modular.to.pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).addPadding(
                    EdgeInsets.symmetric(
                      horizontal: 20.width,
                      vertical: 20.height,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
