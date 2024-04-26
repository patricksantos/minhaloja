import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/presentation_layer/components/screen_loading.dart';
import 'package:minhaloja/presentation_layer/modules/product_details/cubit/product_details_cubit.dart';
import 'package:minhaloja/presentation_layer/modules/product_details/cubit/product_details_state.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

import '../../../presentation_layer/components/default_button.dart';
import '../../../presentation_layer/components/text_input_default.dart';

import 'package:minhaloja/data_layer/data_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductDTO? product;
  final String? productId;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.productId,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late CartCubit _cartCubit;
  late ProductDetailsCubit _productDetailsCubit;

  late CarouselController _carouselController;
  late TextEditingController _textEditingController;

  ProductListCartDTO? productCart;
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

    _productDetailsCubit = Modular.get<ProductDetailsCubit>();
    if (widget.product == null) {
      _productDetailsCubit.getProductDetails(productId: widget.productId ?? '');
    } else if (widget.product == null && widget.productId == '') {
      Modular.to.pushNamed(PageRoutes.home);
    }
    _carouselController = CarouselController();
    _textEditingController = TextEditingController();

    print('productCart');
    print(productCart);
    productCart = _cartCubit.state.productListCart.firstWhereOrNull(
        (e) => e.productId.toString() == widget.product?.id.toString());
    print(productCart);
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocConsumer<CartCubit, CartState>(
        bloc: _cartCubit,
        listener: (context, cartState) {
          productCart = cartState.productListCart
              .where((e) =>
                  e.productId.toString() == widget.product?.id.toString())
              .first;
        },
        builder: (context, cartState) {
          return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              bloc: _productDetailsCubit,
              builder: (context, state) {
                if (widget.product == null && state.product == null) {
                  return const ScreenLoading();
                }
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 0,
                    centerTitle: true,
                  ),
                  backgroundColor: design.white,
                  body: CustomScrollView(
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
                                (widget.product ?? state.product!)
                                    .name
                                    .toCapitalized(),
                                style: design
                                    .h5(color: design.white)
                                    .copyWith(fontWeight: FontWeight.w700),
                              )
                            : null,
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 12.width,
                            ),
                            child: InkWell(
                              onTap: () => Share.share(
                                'Veja o ${(widget.product ?? state.product!).name} no link do nosso site ${widget.productId == '' ? Uri.base.toString() + (widget.product ?? state.product!).id.toString() : Uri.base}',
                                subject:
                                    (widget.product ?? state.product!).name,
                              ),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    const Color.fromARGB(0, 167, 167, 167)
                                        .withOpacity(.5),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.height, right: 2.width),
                                  child: Icon(
                                    Icons.share,
                                    color: design.white,
                                    size: 22.fontSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        leading: Container(
                          padding: EdgeInsets.only(
                            left: 12.width,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.productId != null
                                      ? Modular.to.pushReplacementNamed(
                                          PageRoutes.home,
                                        )
                                      : Modular.to.pop();
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      const Color.fromARGB(0, 167, 167, 167)
                                          .withOpacity(.5),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 2.height),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: design.white,
                                      textDirection: TextDirection.ltr,
                                      size: 26.fontSize,
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
                                items: (widget.product ?? state.product!)
                                    .image
                                    .map(
                                      (item) => CachedNetworkImage(
                                        imageUrl: item,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            color: design.secondary300,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error,
                                          color: Colors.grey,
                                        ),
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.topCenter,
                                          height: 500,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(24.0),
                                                    bottomRight:
                                                        Radius.circular(24.0)),
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
                                    children: (widget.product ?? state.product!)
                                        .image
                                        .asMap()
                                        .entries
                                        .map((entry) {
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
                                                : design.secondary300
                                                    .withOpacity(0.5),
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
                                  (widget.product ?? state.product!)
                                      .name
                                      .toCapitalized(),
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
                                  (widget.product ?? state.product!)
                                      .description,
                                  style: design.paragraphS(
                                    color: design.secondary300,
                                  ),
                                ),
                                SizedBox(height: 8.height),
                                if (productCart == null)
                                  Text('Alguma observação?',
                                      style: design.paragraphS(
                                        color: const Color(0xff67676D),
                                      )),
                                SizedBox(height: 8.height),
                                if (productCart == null)
                                  TextInputDefault(
                                    context: context,
                                    controller: _textEditingController,
                                    hintText: 'Escreva uma nota para a loja',
                                    enable: true,
                                  ),
                                if (productCart == null)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 24.height),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        (MediaQuery.of(context).size.width -
                                                    50.width)
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Valor', // 'Total',
                                      style: design
                                          .h5(color: design.secondary100)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'R\$${((widget.product ?? state.product!).value).formatWithCurrency().trim()}',
                                      style: design
                                          .h5(
                                            color: design.secondary100,
                                          )
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 17.height),
                                SizedBox(
                                  height: 51,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // SizedBox(
                                      //   width: 124,
                                      //   child: CounterView(
                                      //     counterCallback: (value) {
                                      //       setState(() {
                                      //         _quantityProduct = value;
                                      //       });

                                      //       if (value <
                                      //           (productCart?.quantity ??
                                      //               value)) {
                                      //         _cartCubit.removeCartProduct(
                                      //           product: widget.product ??
                                      //               state.product!,
                                      //         );
                                      //       }
                                      //     },
                                      //     minNumber: 1,
                                      //     initNumber:
                                      //         productCart?.quantity ?? 1,
                                      //   ),
                                      // ),
                                      // SizedBox(width: 12.width),
                                      Expanded(
                                        flex: 1,
                                        child: DefaultButton(
                                          disable: productCart != null,
                                          label: productCart != null
                                              ? 'Adicionado'
                                              : 'Adicionar',
                                          onPressed: () {
                                            List<ProductDTO> list = [];
                                            while (_quantityProduct != 0) {
                                              list.add((widget.product ??
                                                      state.product!)
                                                  .copyWith(
                                                id: (widget.product ??
                                                        state.product!)
                                                    .id,
                                                note: _textEditingController
                                                            .text !=
                                                        ''
                                                    ? _textEditingController
                                                        .text
                                                    : null,
                                              ));
                                              _quantityProduct--;
                                            }
                                            _cartCubit.addAllCartProducts(
                                              products: list,
                                            );
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
                );
              });
        });
  }
}
