import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../presentation_layer/components/pull_to_refresh.dart';
import '../../../presentation_layer/modules/home/cubit/home_cubit.dart';
import '../../../presentation_layer/modules/order/cubit/order_cubit.dart';
import '../../../presentation_layer/modules/order/cubit/order_state.dart';
import '../../../presentation_layer/components/default_button.dart';
import '../../../presentation_layer/components/product_details.dart';
import '../../components/bottom_sheet_modal.dart';
import 'components/content_order_item.dart';

import 'package:quickfood/infra/infra.dart';

class OrderPage extends StatefulWidget {
  final bool isExpanded;
  const OrderPage({
    super.key,
    required this.isExpanded,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderCubit _orderCubit;
  late AuthCubit _authCubit;
  late StoreCubit _storeCubit;
  late HomeCubit _homeCubit;

  double _totalValue = 0.0;
  var popModal = true;

  @override
  void initState() {
    super.initState();
    _authCubit = Modular.get<AuthCubit>();
    _storeCubit = Modular.get<StoreCubit>();
    _orderCubit = Modular.get<OrderCubit>();
    _homeCubit = Modular.get<HomeCubit>();

    _orderCubit.getOrder(
      userId: _authCubit.state.user?.id! ?? '',
      storeType: _storeCubit.state.storeType,
    );
  }

  Future<void> _load() async {
    await Future.wait([
      _orderCubit.getOrder(
        userId: _authCubit.state.user?.id! ?? '',
        storeType: _storeCubit.state.storeType,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocConsumer<OrderCubit, OrderState>(
      bloc: _orderCubit,
      listener: (context, state) {
        setState(() {
          _totalValue = 0;
          for (var element in _orderCubit.state.productOrderList) {
            for (var product in element.products) {
              _totalValue = _totalValue + product.value;
            }
          }
        });
      },
      builder: (context, orderState) {
        return PullToRefresh(
          onRefresh: () => _load(),
          child: Container(
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
                        'Pedidos',
                        style: design
                            .h5(color: design.secondary100)
                            .copyWith(fontWeight: FontWeight.w500),
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
                              onTap: Modular.to.pop,
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
              body: _orderCubit.state.actions.contains(OrderAction.creating)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: design.secondary300,
                      ),
                    )
                  : orderState.productOrderList.isNotEmpty
                      ? ListView.builder(
                          controller: ModalScrollController.of(context),
                          padding: EdgeInsets.symmetric(horizontal: 16.width),
                          itemCount: orderState.productOrderList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final productOrderList =
                                orderState.productOrderList.elementAt(index);
                            final productOrder =
                                productOrderList.products.first;
                            return Padding(
                              padding: EdgeInsets.only(top: 8.height),
                              child: ContentOrder(
                                key: UniqueKey(),
                                backgroundImage: productOrder.image.first,
                                title: productOrder.name,
                                price: productOrder.value,
                                description: productOrder.note != null
                                    ? 'Nota: ${productOrder.note}'
                                    : productOrder.description,
                                quantity: productOrderList.products.length,
                                status: productOrder.statusOrder,
                                onTap: () => BottomSheetModal.show(
                                  context: context,
                                  content: ProductDetails(
                                    product: productOrder,
                                  ),
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
                                Icons.receipt_long_rounded,
                                color: design.secondary300,
                                size: 60.fontSize,
                              ),
                              SizedBox(height: 8.height),
                              Text(
                                'Você ainda nāo possui um pedido',
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
                        (MediaQuery.of(context).size.width - 40.width).width ~/
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
                        'R\$${_totalValue.formatWithCurrency().trim()}',
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
                  _storeCubit.state.storeType == StoreType.delivery
                      ? SizedBox(
                          height: 51,
                          child: DefaultButton(
                            label: 'Falar com Loja',
                            primaryColor: const Color(0xff25d366),
                            disable: orderState.productOrderList.isEmpty,
                            onPressed: () async {
                              var text =
                                  'Olá gostaria de falar sobre o pedido de número #${orderState.productOrderList.first.order.toString()}';
                              var url =
                                  'https://api.whatsapp.com/send/?phone=${_homeCubit.state.restaurant?.phoneNumber}&text=$text&type=phone_number&app_absent=0';

                              if (!await launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw Exception('Could not launch $url');
                              }
                            },
                          ),
                        )
                      : SizedBox(
                          height: 51,
                          child: DefaultButton(
                            label: 'Pedir Conta',
                            disable: orderState.productOrderList.isEmpty,
                            onPressed: () {
                              _orderCubit.finishOrder();
                              Modular.to.pop();
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
          ),
        );
      },
    );
  }
}