import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../presentation_layer/modules/delivery/components/content_user_address.dart';
import '../../../presentation_layer/modules/delivery/components/list_view_products_cart.dart';
import '../../../presentation_layer/modules/delivery/components/payment_delivery.dart';
import '../../../presentation_layer/components/default_button.dart';
import '../../../presentation_layer/modules/home/cubit/home_cubit.dart';

import 'package:minhaloja/data_layer/data_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class DeliveryPage extends StatefulWidget {
  final double totalValue;

  const DeliveryPage({
    super.key,
    required this.totalValue,
  });

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  late CartCubit _cartCubit;
  late AuthCubit _authCubit;
  late HomeCubit _homeCubit;
  late StoreCubit _storeCubit;

  late PageController _controller;

  final String character = 'Á vista';
  var currentPage = 0;

  @override
  void initState() {
    super.initState();
    _cartCubit = Modular.get<CartCubit>();
    _authCubit = Modular.get<AuthCubit>();
    _homeCubit = Modular.get<HomeCubit>();
    _storeCubit = Modular.get<StoreCubit>();

    _authCubit.getAddress(userId: _authCubit.state.user?.id ?? '');
    _storeCubit.getFormPayment();

    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: _authCubit,
      builder: (context, authState) {
        return BlocBuilder<CartCubit, CartState>(
          bloc: _cartCubit,
          builder: (context, cartState) {
            return Container(
              decoration: BoxDecoration(
                color: design.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              height: MediaQuery.of(context).size.height * .95,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 70.height,
                  centerTitle: true,
                  title: Text(
                    'Sacola',
                    style: design
                        .h5(color: design.secondary100)
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  leading: Container(
                    padding: EdgeInsets.only(
                      left: 10.width,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: currentPage == 0
                              ? Modular.to.pop
                              : () => setState(() {
                                    currentPage = 0;
                                    _controller.jumpToPage(currentPage);
                                  }),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.only(top: 2.height),
                              child: RotatedBox(
                                quarterTurns: currentPage == 0 ? 1 : 2,
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
                  ),
                ),
                body: PageView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListViewProductsCart(
                      productListCart: cartState.productListCart,
                    ),
                    finishOrderDelivery(
                      context: context,
                      productListCart: cartState.productListCart,
                      design: design,
                    ),
                  ],
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
                          (MediaQuery.of(context).size.width - 50.width)
                                  .width ~/
                              (8 + 3).width,
                          (_) => Container(
                            width: 8,
                            height: 1.5,
                            color: const Color(0xff939393),
                            margin:
                                EdgeInsets.symmetric(horizontal: (3 / 2).width),
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
                          'R\$${widget.totalValue.formatWithCurrency().trim()}',
                          style: design
                              .h5(
                                color: design.secondary100,
                              )
                              .copyWith(
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
                        label:
                            currentPage == 0 ? 'Continuar' : 'Finalizar Pedido',
                        disable: cartState.productListCart.isEmpty ||
                            (currentPage != 0 &&
                                _authCubit.validateUserAddress()),
                        onPressed: () {
                          setState(() {
                            if (currentPage == 0) {
                              currentPage += 1;
                            } else {
                              // currentPage = 0;
                              _cartCubit
                                  .createOrder(
                                    productOrderList: cartState.productListCart,
                                    restaurantId:
                                        _homeCubit.state.restaurant?.id ?? '',
                                    userId: authState.user?.id ?? '',
                                    storeType: StoreType.delivery,
                                    formPayment: _storeCubit.state.formPayment,
                                    listFormPayment:
                                        _storeCubit.state.listFormPayment,
                                  )
                                  .then(
                                    (value) => _showBottomSheetFeedback(
                                      context: context,
                                      design: design,
                                    ),
                                  );
                            }
                            _controller.jumpToPage(currentPage);
                          });
                        },
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
      },
    );
  }

  Widget finishOrderDelivery({
    required BuildContext context,
    required List<ProductListCartDTO> productListCart,
    required FoodAppDesign design,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ContentUserAddress(
            productListCart: productListCart,
            authCubit: _authCubit,
            controller: _controller,
          ),
          SizedBox(height: 24.height),
          _storeCubit.state.actions
                  .contains(StoreAction.formPaymentSuccessfully)
              ? PaymentDelivery(
                  character: character,
                  storeCubit: _storeCubit,
                )
              : Container(),
        ],
      ),
    );
  }

  void _showBottomSheetFeedback({
    required BuildContext context,
    required FoodAppDesign design,
  }) {
    Modular.to.pop();
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
}
