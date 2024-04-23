import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../presentation_layer/modules/delivery/delivery_module.dart';
import '../../../presentation_layer/components/bottom_sheet_modal.dart';
import '../../../presentation_layer/components/product_details.dart';
import '../../../presentation_layer/modules/home/components/bottom_switch_type_store.dart';
import '../../../presentation_layer/modules/cart_products/components/content_cart_item.dart';
import '../../../presentation_layer/components/default_button.dart';

import 'package:minhaloja/infra/infra.dart';

class CartProductsPage extends StatefulWidget {
  final String userId;
  final String restaurantId;
  final bool isExpanded;

  const CartProductsPage({
    super.key,
    required this.userId,
    required this.restaurantId,
    required this.isExpanded,
  });

  @override
  State<CartProductsPage> createState() => _CartProductsPageState();
}

class _CartProductsPageState extends State<CartProductsPage> {
  late CartCubit _cartCubit;
  late StoreCubit _storeCubit;
  double _totalValue = 0.0;

  @override
  void initState() {
    super.initState();
    _cartCubit = Modular.get<CartCubit>();
    _storeCubit = Modular.get<StoreCubit>();
    _storeCubit.getFormPayment();

    setState(() {
      _totalValue = 0;
      for (var element in _cartCubit.state.products) {
        _totalValue = _totalValue + element.value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocConsumer<CartCubit, CartState>(
      bloc: _cartCubit,
      listener: (context, state) {
        setState(() {
          _totalValue = 0;
          for (var element in state.products) {
            _totalValue = _totalValue + element.value;
          }
        });
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: design.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          height: !widget.isExpanded
              ? MediaQuery.of(context).size.height * .95
              : MediaQuery.of(context).size.height * .95 - 70,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: !widget.isExpanded ? 70.height : 0,
              centerTitle: true,
              title: !widget.isExpanded
                  ? Text(
                      'Carrinho',
                      style: design
                          .h5(
                            color: design.secondary100,
                          )
                          .copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    )
                  : null,
              leading: !widget.isExpanded
                  ? Container(
                      padding: EdgeInsets.only(
                        left: 10.width,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            // onTap: Modular.to.pop,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.only(top: 2.height),
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.arrow_back_ios_outlined,
                                    color: design.secondary100,
                                    textDirection: TextDirection.rtl,
                                    size: 26.fontSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
            body: state.productListCart.isNotEmpty
                ? ListView.builder(
                    controller: ModalScrollController.of(context),
                    padding: EdgeInsets.symmetric(horizontal: 16.width),
                    itemCount: state.productListCart.length,
                    itemBuilder: (BuildContext context, int index) {
                      final productListCart =
                          state.productListCart.elementAt(index);
                      final productItem = productListCart.products.first;
                      return Padding(
                        padding: EdgeInsets.only(top: 8.height),
                        child: ContentCartItem(
                          key: UniqueKey(),
                          backgroundImage: productItem.image.first,
                          title: productItem.name,
                          price: productItem.value,
                          counterCallback: (value) {
                            final quantity = productListCart.quantity;
                            if (value > quantity) {
                              _cartCubit.addCartProduct(
                                product: productItem,
                              );
                            } else if (value < quantity) {
                              _cartCubit.removeCartProduct(
                                product: productItem,
                              );
                            }
                          },
                          quantity: productListCart.quantity,
                          note: productItem.note != null
                              ? 'Nota: ${productItem.note}'
                              : productItem.description,
                          onTap: () => Modular.to.pushNamed(
                            PageRoutes.productDetails,
                            arguments: {'product': productItem},
                          ),
                          // BottomSheetModal.show(
                          //   context: context,
                          //   content: ProductDetails(
                          //     product: productItem,
                          //   ),
                          // ),
                          onTapRemoveItem: () => _cartCubit.removeCartProduct(
                            product: productItem,
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: design.secondary300,
                          size: 60.fontSize,
                        ),
                        SizedBox(height: 8.height),
                        Text(
                          'Nenhum item foi adicionado\nao carrinho',
                          textAlign: TextAlign.center,
                          style: design
                              .labelM(
                                color: design.secondary300,
                              )
                              .copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.height),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      (MediaQuery.of(context).size.width - 50.width).width ~/
                          (8 + 3).width,
                      (_) => Container(
                        width: 8,
                        height: 1.5,
                        color: const Color(0xff939393),
                        margin: EdgeInsets.symmetric(horizontal: (3 / 2).width),
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
                          .h5(color: design.secondary100)
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'R\$${_totalValue.formatWithCurrency().trim()}',
                      style: design.h5(color: design.secondary100).copyWith(
                            fontSize: 20.fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 17.height),
                SizedBox(
                  height: 51,
                  child: DefaultButton(
                    label: 'Finalizar Pedido',
                    primaryColor: design.terciary100,
                    disable: state.productListCart.isEmpty,
                    onPressed: _storeCubit.state.storeType == StoreType.menu
                        ? () {
                            _cartCubit.createOrder(
                              productOrderList: state.productListCart,
                              restaurantId: widget.restaurantId,
                              storeType: _storeCubit.state.storeType,
                              userId: widget.userId,
                              formPayment: _storeCubit.state.formPayment,
                              listFormPayment:
                                  _storeCubit.state.listFormPayment,
                            );
                            _showBottomSheetFeedback(
                              context: context,
                              design: design,
                            );
                          }
                        : _storeCubit.state.storeType == StoreType.delivery
                            ? () => BottomSheetModal.show(
                                  context: context,
                                  content: DeliveryModule(
                                    totalValue: _totalValue,
                                  ),
                                )
                            : () => bottomSheetStoreType(),
                  ),
                ),
                SizedBox(height: 16.height),
              ],
            ).addPadding(
              EdgeInsets.symmetric(
                horizontal: 20.width,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheetFeedback({
    required BuildContext context,
    required FoodAppDesign design,
  }) {
    context.showSuccessFeedbackPage(
      context: context,
      buttonTitle: 'Fechar',
      titleAppBar: 'Pedido',
      icon: Image.asset(
        PathImages.onlineOrder,
        height: 180.fontSize,
      ),
      onPressed: () => Modular.to.popUntil(
        ModalRoute.withName(PageRoutes.home),
      ),
      title: 'Pedido feito com sucesso!!!',
      message:
          'Para mais detalhes acompanhe a aba de pedidos na tela inicial...',
    );
  }

  void bottomSheetStoreType() {
    BottomSheetModal.show(
      context: context,
      enableDrag: true,
      isDismissible: true,
      content: BottomSwitchTypeStore(
        onTapDelivery: () {
          setState(() {
            _storeCubit.getStoreType(
              storeType: StoreType.delivery,
            );
          });
        },
        onTapMenu: () {
          setState(() {
            _storeCubit.getStoreType(
              storeType: StoreType.menu,
            );
          });
        },
      ),
    );
  }
}
