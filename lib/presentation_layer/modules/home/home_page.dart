import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/presentation_layer/components/screen_loading.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../presentation_layer/components/product_featured_item.dart';
import '../../../presentation_layer/components/pull_to_refresh.dart';
import '../../../presentation_layer/modules/home/components/bottom_switch_type_store.dart';
import '../../../presentation_layer/modules/home/components/new_details_store.dart';
import '../../components/bottom_sheet_modal.dart';
import '../../../presentation_layer/modules/home/components/featured_itens.dart';
import '../../../presentation_layer/modules/home/components/list_products.dart';
import '../../../presentation_layer/modules/home/cubit/home_cubit.dart';
import '../../../presentation_layer/modules/home/cubit/home_state.dart';

import 'package:minhaloja/infra/infra.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeCubit _homeCubit;
  late CartCubit _cartCubit;
  late AuthCubit _authCubit;
  late StoreCubit _storeCubit;

  late TabController _tabController;
  late ScrollController _controller;

  // bool _buttonNextCurrentPage = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _storeCubit = Modular.get<StoreCubit>();

    _authCubit = Modular.get<AuthCubit>();
    _authCubit.loginAnonymous();

    _homeCubit = Modular.get<HomeCubit>();

    _cartCubit = Modular.get<CartCubit>();
    _cartCubit.getListCartStorage();

    _controller = ScrollController();
    // _controller.addListener(() {
    //   if (_controller.offset >= _controller.position.maxScrollExtent) {
    //     setState(() => _buttonNextCurrentPage = true);
    //   } else if (_controller.offset <= _controller.position.minScrollExtent) {
    //     setState(() => _buttonNextCurrentPage = false);
    //   }
    // });

    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {});
      });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.index != _currentPage) {
        setState(() {
          _currentPage = _tabController.index;
        });
      }
    });
  }

  Future<void> _load() async {
    await Future.wait([]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocBuilder<StoreCubit, StoreState>(
      bloc: _storeCubit,
      builder: (_, stateStore) {
        return BlocBuilder<CartCubit, CartState>(
          bloc: _cartCubit,
          builder: (context, stateCart) {
            return BlocBuilder<HomeCubit, HomeState>(
              bloc: _homeCubit,
              builder: (_, state) {
                if (state.loading) {
                  return ScreenLoading(backgroundColor: design.primary100);
                }
                return Skeletonizer(
                  ignoreContainers: true,
                  ignorePointers: true,
                  enabled: state.loading,
                  child: Scaffold(
                    backgroundColor: design.white,
                    body: PullToRefresh(
                      onRefresh: () => _load(),
                      child: DefaultTabController(
                        initialIndex: _currentPage,
                        length: state.categories?.length ?? 0,
                        child: NestedScrollView(
                          controller: _controller,
                          headerSliverBuilder: (
                            BuildContext context,
                            bool innerBoxIsScrolled,
                          ) =>
                              [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  NewDetailStore(
                                    icon: state.restaurant?.logoUrl ??
                                        PathImages.iconRestaurant,
                                    storeType: stateStore.storeType,
                                    onTapStoreType: () =>
                                        _bottomSheetStoreType(),
                                    backgroundImage:
                                        state.restaurant?.banner ?? [''],
                                    nameRestaurant:
                                        state.restaurant?.name ?? 'Minha Loja',
                                    type: state.restaurant?.segment ?? '',
                                    description:
                                        state.restaurant?.description ?? '',
                                    tags: const [''],
                                    onTapOrder: () =>
                                        Modular.to.pushNamed(PageRoutes.order),
                                  ),
                                  if (_homeCubit.state.itens?.isNotEmpty ??
                                      false)
                                    FeaturedItens(
                                      itens: _homeCubit
                                          .featuredItens(maxItens: 6)
                                          .where((element) =>
                                              element.emphasis == true)
                                          .map(
                                            (product) => ProductFeaturedItem(
                                              key: UniqueKey(),
                                              backgroundImage:
                                                  product.image.first,
                                              title: product.name,
                                              price: product.value,
                                              onTap: () => Modular.to.pushNamed(
                                                PageRoutes.productDetails(
                                                  product.id.toString(),
                                                ),
                                                arguments: {'product': product},
                                              ),
                                              onTapCart: () =>
                                                  _cartCubit.addCartProduct(
                                                product: product.copyWith(
                                                  id: product.id,
                                                ),
                                              ),
                                            ).addPadding(EdgeInsets.only(
                                              right: 12.width,
                                            )),
                                          )
                                          .toList(),
                                    ),
                                ],
                              ),
                            ),
                            if (_homeCubit.state.categories?.isNotEmpty ??
                                false)
                              SliverAppBar(
                                pinned: true,
                                floating: true,
                                backgroundColor: design.white,
                                toolbarHeight: 0,
                                elevation: 0,
                                surfaceTintColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                bottom: PreferredSize(
                                  preferredSize: const Size.fromHeight(50.0),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        left: 16.width,
                                        right: 16.width,
                                        child: Container(
                                          height: 1.8, // 2
                                          color: design.secondary100,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: 40,
                                          child: TabBar(
                                            tabAlignment: TabAlignment.start,
                                            indicatorWeight: 2,
                                            controller: _tabController,
                                            labelColor: design.primary100,
                                            indicatorColor: design.primary100,
                                            unselectedLabelColor:
                                                design.secondary100,
                                            dividerColor: Colors.transparent,
                                            isScrollable: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            padding: EdgeInsets.only(
                                              left: 16.width,
                                            ),
                                            tabs: state.categories
                                                    ?.map((category) => Tab(
                                                          text: category.name
                                                              .toCapitalized(),
                                                        ))
                                                    .toList() ??
                                                [],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                          body: ListProducts(
                            controller: _tabController,
                            tabs: state.categories ?? [],
                            listItens: state.itens ?? [],
                          ),
                        ),
                      ),
                    ),
                    // floatingActionButton: _buttonNextCurrentPage
                    //     ? FloatingButtonCurrentPage(controller: _tabController)
                    //     : null,
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: design.primary100,
                      onPressed: () =>
                          Modular.to.pushNamed(PageRoutes.cartProducts),
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: design.white,
                        size: 24,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void _bottomSheetStoreType() {
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
