// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// import '../../../presentation_layer/modules/cart_products/cart_products_module.dart';
// import '../../../presentation_layer/modules.dart';
// import '../../components/bottom_sheet_modal.dart';
// import '../../../presentation_layer/components/content_featured_item.dart';
// import '../../../presentation_layer/components/product_details.dart';
// import '../../../presentation_layer/components/scrool_to_hide.dart';
// import '../../../presentation_layer/modules/home/components/bottom_cart_bar.dart';
// import '../../../presentation_layer/modules/home/components/details_store.dart';
// import '../../../presentation_layer/modules/home/components/featured_itens.dart';
// import '../../../presentation_layer/modules/home/components/floating_button_current_page.dart';
// import '../../../presentation_layer/modules/home/components/list_products.dart';
// import '../../../presentation_layer/modules/home/cubit/home_cubit.dart';
// import '../../../presentation_layer/modules/home/cubit/home_state.dart';

// import 'package:minhaloja/infra/infra.dart';

// class HomePageOld extends StatefulWidget {
//   final String store;

//   const HomePageOld({
//     super.key,
//     required this.store,
//   });

//   @override
//   State<HomePageOld> createState() => _HomePageOldState();
// }

// class _HomePageOldState extends State<HomePageOld> with TickerProviderStateMixin {
//   late HomeCubit _homeCubit;
//   late CartCubit _cartCubit;
//   late AuthCubit _authCubit;

//   late TabController _tabController;
//   late ScrollController _controller;

//   bool _buttonNextCurrentPage = false;
//   int _currentPage = 0;
//   double _amountCart = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _authCubit = Modular.get<AuthCubit>();
//     _authCubit.loginAnonymous();

//     _homeCubit = Modular.get<HomeCubit>();
//     _homeCubit.getRestaurant(name: widget.store);

//     _cartCubit = Modular.get<CartCubit>();
//     _cartCubit.getListCartStorage();

//     _controller = ScrollController();
//     _controller.addListener(() {
//       if (_controller.offset >= _controller.position.maxScrollExtent &&
//           !_controller.position.outOfRange) {
//         setState(() {
//           _buttonNextCurrentPage = true;
//         });
//       } else {
//         setState(() {
//           _buttonNextCurrentPage = false;
//         });
//       }
//     });

//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging ||
//           _tabController.index != _currentPage) {
//         setState(() {
//           _currentPage = _tabController.index;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final design = DesignSystem.of(context);
//     return BlocConsumer<CartCubit, CartState>(
//       bloc: _cartCubit,
//       listener: (context, stateCart) {
//         if (stateCart.products.isNotEmpty) {
//           setState(() {
//             _amountCart = 0;
//             for (var element in stateCart.products) {
//               _amountCart = _amountCart + element.value;
//             }
//           });
//         } else {
//           setState(() {
//             _amountCart = 0;
//           });
//         }
//       },
//       builder: (context, stateCart) {
//         return BlocConsumer<HomeCubit, HomeState>(
//           bloc: _homeCubit,
//           listenWhen: (previous, current) {
//             if (previous.restaurant != current.restaurant) {
//               _homeCubit.getCategoriesItens(
//                 restaurantId: _homeCubit.state.restaurant?.id ?? '',
//               );
//               _homeCubit.getFeaturedItens(
//                 restaurantId: _homeCubit.state.restaurant?.id ?? '',
//               );
//               // if (stateCart.storeType == StoreType.none) {
//               //   // bottomSheetStoreType();
//               // }
//             }
//             if (current.categories != null) {
//               _tabController = TabController(
//                 length: _homeCubit.state.categories!.length,
//                 vsync: this,
//               );
//             }
//             return true;
//           },
//           listener: (context, state) {
//             var error = state.failure != null;
//             if (error || state.restaurant == null) {
//               Modular.to.pushNamed(PageRoutes.qrcode);
//             }
//           },
//           builder: (_, state) {
//             return Scaffold(
//               backgroundColor: design.white,
//               bottomNavigationBar: ScrollToHide(
//                 controller: _controller,
//                 heightWidget: 70,
//                 child: BottomCartBar(
//                   onTap: () => BottomSheetModal.show(
//                     context: context,
//                     content: CartProductsModule(
//                       restaurantId: state.restaurant?.id! ?? '',
//                       userId: _authCubit.state.user?.id ?? '',
//                       isExpanded: false,
//                     ),
//                   ),
//                   onTapOrder: () => BottomSheetModal.show(
//                     context: context,
//                     content: OrderModule(),
//                   ),
//                 ),
//               ),
//               floatingActionButton: _buttonNextCurrentPage
//                   ? FloatingButtonCurrentPage(
//                       controller: _tabController,
//                     )
//                   : null,
//               body: state.actions.contains(HomeAction.creating)
//                   ? const Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : DefaultTabController(
//                       initialIndex: _currentPage,
//                       length: state.categories?.length ?? 0,
//                       child: NestedScrollView(
//                         controller: _controller,
//                         headerSliverBuilder: (
//                           BuildContext context,
//                           bool innerBoxIsScrolled,
//                         ) =>
//                             [
//                           SliverList(
//                             delegate: SliverChildListDelegate(
//                               [
//                                 DetailStore(
//                                   icon: state.restaurant?.logoUrl ??
//                                       PathImages.iconRestaurant,
//                                   backgroundImage:
//                                       state.restaurant?.backgroundUrl ??
//                                           PathImages.pizza,
//                                   nameRestaurant:
//                                       state.restaurant?.name.toCapitalized() ??
//                                           'Store',
//                                   type: state.restaurant?.segment ?? 'segment',
//                                   description: state.restaurant?.description ??
//                                       'description',
//                                   tags: state.categories
//                                           ?.getRange(0, 3)
//                                           .map((e) => e.name.toCapitalized())
//                                           .toList() ??
//                                       [
//                                         'PIZZA',
//                                         'Burgers',
//                                         'Fast Food',
//                                       ],
//                                   onTapOrder: () => BottomSheetModal.show(
//                                     context: context,
//                                     content: OrderModule(),
//                                   ),
//                                 ),
//                                 FeaturedItens(
//                                   itens: _homeCubit
//                                       .featuredItens(maxItens: 6)
//                                       .where(
//                                           (element) => element.emphasis == true)
//                                       .map(
//                                         (product) => ContentFeaturedItem(
//                                           key: UniqueKey(),
//                                           backgroundImage: product.image.first,
//                                           title: product.name,
//                                           price: product.value,
//                                           onTap: () => BottomSheetModal.show(
//                                             context: context,
//                                             content: ProductDetails(
//                                               product: product,
//                                             ),
//                                           ),
//                                           onTapCart: () =>
//                                               _cartCubit.addCartProduct(
//                                             product: product.copyWith(
//                                               id: product.id,
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                       .toList(),
//                                 ),
//                                 SizedBox(height: 15.height),
//                               ],
//                             ),
//                           ),
//                           SliverAppBar(
//                             pinned: true,
//                             floating: true,
//                             backgroundColor: design.white,
//                             toolbarHeight: 0,
//                             elevation: 0,
//                             bottom: PreferredSize(
//                               preferredSize: const Size.fromHeight(50.0),
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     bottom: 0,
//                                     left: 16.width,
//                                     right: 16.width,
//                                     child: Container(
//                                       height: 2,
//                                       color: design.secondary100,
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: SizedBox(
//                                       height: 40,
//                                       child: TabBar(
//                                         indicatorWeight: 2,
//                                         controller: _tabController,
//                                         labelColor: design.primary100,
//                                         indicatorColor: design.primary100,
//                                         unselectedLabelColor:
//                                             design.secondary100,
//                                         isScrollable: true,
//                                         physics: const BouncingScrollPhysics(),
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 16.width,
//                                         ),
//                                         tabs: state.categories
//                                                 ?.map((category) => Tab(
//                                                       text: category.name
//                                                           .toCapitalized(),
//                                                     ))
//                                                 .toList() ??
//                                             [],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                         body: ListProducts(
//                           controller: _tabController,
//                           tabs: state.categories ?? [],
//                           listItens: state.itens ?? [],
//                         ),
//                       ),
//                     ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
