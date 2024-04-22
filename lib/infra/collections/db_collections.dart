class DBCollections {
  static const restaurant = 'restaurant';
  static const address = 'address';
  static const userAddress = 'user_address';
  static const user = 'user';
  static const category = 'category';
  static const product = 'product';
  static const order = 'order';
  static const orderProduct = 'order_product';
  static const formPayment = 'form_payment';
}
  // void getFeaturedItens2() {
  //   emit(
  //     state.copyWith(
  //       itens: [
  //         ProductDTO(
  //           name: 'Chicken Hawaiian',
  //           categoryId: 'comida',
  //           description:
  //               'Lorem Ipsum is simply dummy text and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 20.00,
  //           image: [PathImages.pizza, PathImages.pizza, PathImages.pizza],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Chicken Hawaiian',
  //           categoryId: 'comida',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 20.00,
  //           image: [PathImages.pizza, PathImages.pizza],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Chicken Hawaiian',
  //           categoryId: 'comida',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 20.00,
  //           image: [PathImages.pizza],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Chicken Hawaiian',
  //           categoryId: 'comida',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 20.00,
  //           image: [PathImages.pizza],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Chicken Hawaiian',
  //           categoryId: 'comida',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 20.00,
  //           image: [PathImages.pizza],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Chicken Hawaiian',
  //           categoryId: 'comida',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 20.00,
  //           image: [PathImages.pizza],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Chicken Hawaiian',
  //           categoryId: 'comida',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 20.00,
  //           image: [PathImages.pizza],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Refrigerante',
  //           categoryId: 'bebidas',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 9.00,
  //           image: [PathImages.refrigerante],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Suco',
  //           categoryId: 'bebidas',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 5.00,
  //           image: [PathImages.refrigerante],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Vitamina',
  //           categoryId: 'bebidas',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 5.00,
  //           image: [PathImages.refrigerante],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Sorvete',
  //           categoryId: 'sobremesa',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 10.00,
  //           image: [PathImages.sorvete],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Açai',
  //           categoryId: 'sobremesa',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 5.00,
  //           image: [PathImages.sorvete],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Pudim',
  //           categoryId: 'sobremesa',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 5.00,
  //           image: [PathImages.sorvete],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Bolo de Pote',
  //           categoryId: 'sobremesa',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 5.00,
  //           image: [PathImages.sorvete],
  //           restaurantId: "1",
  //         ),
  //         ProductDTO(
  //           name: 'Docinhos',
  //           categoryId: 'sobremesa',
  //           description:
  //               'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
  //           value: 5.00,
  //           image: [PathImages.sorvete],
  //           restaurantId: "1",
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void getCategoriesItens2() {
  //   emit(
  //     state.copyWith(
  //       categories: [
  //         CategoryEntity(
  //           id: "1",
  //           name: 'comida',
  //           restaurantId: "1",
  //         ),
  //         CategoryEntity(
  //           id: "2",
  //           name: 'bebidas',
  //           restaurantId: "1",
  //         ),
  //         CategoryEntity(
  //           id: "3",
  //           name: 'sobremesa',
  //           restaurantId: "1",
  //         ),
  //       ],
  //     ),
  //   );
  // }
