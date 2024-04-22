import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../presentation_layer/modules/order/components/content_order_item.dart';

import '../../../../data_layer/dtos/product/product_list_cart_dto.dart';

import 'package:minhaloja/infra/infra.dart';

class ListViewProductsCart extends StatelessWidget {
  final List<ProductListCartDTO> productListCart;

  const ListViewProductsCart({
    super.key,
    required this.productListCart,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ModalScrollController.of(context),
      padding: EdgeInsets.symmetric(horizontal: 16.width),
      itemCount: productListCart.length,
      itemBuilder: (BuildContext context, int index) {
        final listCart = productListCart.elementAt(index);
        final productItem = listCart.products.first;
        return Padding(
          padding: EdgeInsets.only(top: 8.height),
          child: ContentOrder(
            key: UniqueKey(),
            backgroundImage: productItem.image.first,
            title: productItem.name,
            price: productItem.value,
            description: productItem.note != null
                ? 'Nota: ${productItem.note}'
                : productItem.description,
            quantity: listCart.products.length,
            status: StatusOrder.none,
            onTap: () {},
          ),
        );
      },
    );
  }
}
