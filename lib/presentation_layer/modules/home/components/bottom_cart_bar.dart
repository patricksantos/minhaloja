import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:minhaloja/infra/infra.dart';

class BottomCartBar extends StatefulWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapOrder;

  const BottomCartBar({
    super.key,
    this.onTap,
    this.onTapOrder,
  });

  @override
  State<BottomCartBar> createState() => _BottomCartBarState();
}

class _BottomCartBarState extends State<BottomCartBar> {
  late CartCubit _cartCubit;

  double _amountCart = 0.0;

  @override
  void initState() {
    super.initState();
    _cartCubit = Modular.get<CartCubit>();
    _cartCubit.getListCartStorage();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocConsumer<CartCubit, CartState>(
        bloc: _cartCubit,
        listener: (context, state) {
          if (state.products.isNotEmpty) {
            setState(() {
              _amountCart = 0;
              for (var element in state.products) {
                _amountCart = _amountCart + element.value;
              }
            });
          } else {
            setState(() {
              _amountCart = 0;
            });
          }
        },
        builder: (_, state) {
          return Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 16.width),
            decoration: BoxDecoration(
              color: design.secondary100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0.height,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: _slider(
                        color: design.white,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: widget.onTap,
                            child: Container(
                              decoration: BoxDecoration(
                                color: design.primary100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              height: 40,
                              width: 40,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: Icon(
                                  Icons.shopping_cart_rounded,
                                  color: design.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.width),
                          Text(
                            'Adicionado\nno Carrinho',
                            style: design
                                .labelM(
                                  color: design.white,
                                )
                                .copyWith(
                                  fontSize: 14.fontSize,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                      state.products.isNotEmpty
                          ? Row(
                              children: [
                                InkWell(
                                  onTap: widget.onTap,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.width),
                                    decoration: BoxDecoration(
                                      color: design.secondary200,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints:
                                        const BoxConstraints(minWidth: 35),
                                    alignment: Alignment.center,
                                    height: 35,
                                    child: Text(
                                      'R\$ ${_amountCart.formatWithCurrency().trim()}',
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
                                ),
                                SizedBox(width: 6.width),
                                InkWell(
                                  onTap: widget.onTap,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.width),
                                    decoration: BoxDecoration(
                                      color: design.secondary200,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    constraints:
                                        const BoxConstraints(minWidth: 35),
                                    alignment: Alignment.center,
                                    height: 35,
                                    child: Text(
                                      state.products.length.toString(),
                                      style: design
                                          .labelM(color: design.white)
                                          .copyWith(
                                            fontSize: 14.fontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: widget.onTapOrder,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: design.secondary200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.receipt_rounded,
                                  color: design.white,
                                  size: 24,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container _slider({required Color color}) {
    return Container(
      height: 4,
      width: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
