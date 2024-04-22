import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../data_layer/dtos/product/product_list_cart_dto.dart';
import '../../../../presentation_layer/modules/delivery/components/address_step.dart';

import 'package:minhaloja/infra/infra.dart';

class ContentUserAddress extends StatelessWidget {
  final List<ProductListCartDTO> productListCart;
  final PageController controller;
  final AuthCubit authCubit;

  const ContentUserAddress({
    super.key,
    required this.productListCart,
    required this.controller,
    required this.authCubit,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entrega',
          style: design
              .h6(color: design.secondary100)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15.height),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 15.height,
            horizontal: 20.width,
          ),
          decoration: BoxDecoration(
            color: design.white,
            border: Border.all(
              color: design.primary100,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: design.secondary300,
                size: 28.fontSize,
              ),
              SizedBox(width: 14.width),
              Expanded(
                child: !authCubit.validateUserAddress()
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Entregar em',
                            style: design
                                .labelS(color: design.secondary100)
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text:
                                        '${authCubit.state.userAddress?.street}',
                                    style: design
                                        .labelS(color: design.secondary300)
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Text(
                                ', ${authCubit.state.userAddress?.number}',
                                style: design
                                    .labelS(color: design.secondary300)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text:
                                        '${authCubit.state.userAddress?.neighborhood}',
                                    style: design
                                        .labelS(color: design.secondary300)
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Text(
                                ', ${authCubit.state.userAddress?.zipCode}',
                                style: design
                                    .labelS(color: design.secondary300)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text:
                                        '${authCubit.state.userAddress?.city}',
                                    style: design
                                        .labelS(color: design.secondary300)
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Text(
                                ', ${authCubit.state.userAddress?.state}',
                                style: design
                                    .labelS(color: design.secondary300)
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          authCubit.state.userAddress?.complement != ''
                              ? Text(
                                  '${authCubit.state.userAddress?.complement}',
                                  overflow: TextOverflow.ellipsis,
                                  style: design
                                      .labelS(color: design.secondary300)
                                      .copyWith(fontWeight: FontWeight.w500),
                                )
                              : Container(),
                        ],
                      )
                    : Text(
                        'Cadastre um endereço válido',
                        style: design
                            .labelS(color: design.secondary300)
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
              ),
              SizedBox(width: 12.width),
              IconButton(
                onPressed: () => showCupertinoModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  enableDrag: true,
                  isDismissible: true,
                  builder: (context) {
                    return AddressStep(
                      pageController: controller,
                    );
                  },
                ),
                icon: Icon(
                  Icons.edit,
                  color: design.secondary300,
                  size: 28.fontSize,
                ),
              )
            ],
          ),
        )
      ],
    ).addPadding(
      EdgeInsets.symmetric(
        horizontal: 20.width,
      ),
    );
  }
}
