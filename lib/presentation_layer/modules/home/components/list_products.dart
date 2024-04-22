import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/presentation_layer/components/new_content_item.dart';

import '../../../components/bottom_sheet_modal.dart';
import '../../../../presentation_layer/components/product_details.dart';

import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class ListProducts extends StatefulWidget {
  final List<CategoryEntity> tabs;
  final List<ProductDTO> listItens;
  final TabController controller;

  const ListProducts({
    super.key,
    required this.tabs,
    required this.listItens,
    required this.controller,
  });

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  late CartCubit _cartCubit;

  @override
  void initState() {
    super.initState();
    _cartCubit = Modular.get<CartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(),
      children: _viewsListProducts(
        widget.listItens,
        widget.tabs,
      ),
    );
  }

  List<Widget> _viewsListProducts(
    List<ProductDTO> listItens,
    List<CategoryEntity> tabs,
  ) =>
      tabs.map(
        (tab) {
          final list = listItens
              .where(
                (element) =>
                    element.categoryId == tab.id && element.status == true,
              )
              .toList();
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 16.height,
            ),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.height),
              child: const Divider(),
            ),
            physics: const ClampingScrollPhysics(),
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return NewContentItem(
                backgroundImage: list[index].image.first,
                title: list[index].name,
                description: list[index].description,
                price: list[index].value,
                onTap: () => BottomSheetModal.show(
                  context: context,
                  content: ProductDetails(
                    product: list[index],
                  ),
                ),
                onTapCart: () => _cartCubit.addCartProduct(
                  product: list[index].copyWith(
                    id: list[index].id,
                  ),
                ),
              );
            },
          );
        },
      ).toList();
}
