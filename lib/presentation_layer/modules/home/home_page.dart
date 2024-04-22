import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../presentation_layer/components/product_featured_item.dart';
import '../../../presentation_layer/components/pull_to_refresh.dart';
import '../../../presentation_layer/modules/home/components/bottom_switch_type_store.dart';
import '../../../presentation_layer/modules/home/components/new_details_store.dart';
import 'components/expandable_content_home.dart';
import 'components/bottom_sheet_expandable.dart';
import '../../../presentation_layer/modules.dart';
import '../../components/bottom_sheet_modal.dart';
import '../../../presentation_layer/components/product_details.dart';
import '../../../presentation_layer/modules/home/components/bottom_cart_bar.dart';
import '../../../presentation_layer/modules/home/components/featured_itens.dart';
import '../../../presentation_layer/modules/home/components/floating_button_current_page.dart';
import '../../../presentation_layer/modules/home/components/list_products.dart';
import '../../../presentation_layer/modules/home/cubit/home_cubit.dart';
import '../../../presentation_layer/modules/home/cubit/home_state.dart';

import 'package:quickfood/infra/infra.dart';

class HomePage extends StatefulWidget {
  final String store;

  const HomePage({
    super.key,
    required this.store,
  });

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

  bool _buttonNextCurrentPage = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    if (widget.store.contains('dashboard')) {
      Modular.to.pushReplacementNamed(PageRoutes.dashboard);
    } else if (widget.store.contains('login')) {
      Modular.to.pushReplacementNamed(PageRoutes.login);
    }
    _storeCubit = Modular.get<StoreCubit>();

    _authCubit = Modular.get<AuthCubit>();
    _authCubit.loginAnonymous();

    _homeCubit = Modular.get<HomeCubit>();
    _homeCubit.getRestaurant(name: widget.store);

    _cartCubit = Modular.get<CartCubit>();
    _cartCubit.getListCartStorage();

    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent) {
        setState(() => _buttonNextCurrentPage = true);
      } else if (_controller.offset <= _controller.position.minScrollExtent) {
        setState(() => _buttonNextCurrentPage = false);
      }
    });

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
            return BlocConsumer<HomeCubit, HomeState>(
              bloc: _homeCubit,
              listenWhen: (previous, current) {
                if (previous.restaurant != current.restaurant) {
                  _homeCubit.getCategoriesItens(
                    restaurantId: _homeCubit.state.restaurant?.id ?? '',
                  );
                  _homeCubit.getFeaturedItens(
                      restaurantId: _homeCubit.state.restaurant?.id ?? '');
                }
                if (current.categories != null) {
                  _tabController = TabController(
                    length: _homeCubit.state.categories!.length,
                    vsync: this,
                  );
                }
                return true;
              },
              listener: (context, state) {
                var error = state.failure != null;
                if (error || state.restaurant == null) {
                  Modular.to.pushNamed(PageRoutes.qrcode);
                }
              },
              builder: (_, state) {
                return Scaffold(
                  backgroundColor: design.white,
                  body: BottomSheetExpandable(
                    expandableHeader: const BottomCartBar(),
                    expandableContent: _authCubit.state.user != null
                        ? ExpandableContentHome(
                            restaurantId: state.restaurant?.id! ?? '',
                            userId: _authCubit.state.user?.id ?? '',
                          )
                        : Container(
                            color: design.white,
                            height:
                                MediaQuery.of(context).size.height * .95 - 70,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: design.secondary300,
                              ),
                            ),
                          ),
                    body: state.actions.contains(HomeAction.creating)
                        ? Center(
                            child: CircularProgressIndicator(
                              color: design.secondary300,
                            ),
                          )
                        : PullToRefresh(
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
                                              state.restaurant?.backgroundUrl ??
                                                  PathImages.pizza,
                                          nameRestaurant: state.restaurant?.name
                                                  .toCapitalized() ??
                                              'Store',
                                          type: state.restaurant?.segment ??
                                              'segment',
                                          description:
                                              state.restaurant?.description ??
                                                  'description',
                                          tags: state.categories!.isNotEmpty
                                              ? state.categories!
                                                  .getRange(0, 3)
                                                  .map((e) =>
                                                      e.name.toCapitalized())
                                                  .toList()
                                              : [
                                                  'PIZZA',
                                                  'Burgers',
                                                  'Fast Food',
                                                ],
                                          onTapOrder: () =>
                                              BottomSheetModal.show(
                                            context: context,
                                            content:
                                                OrderModule(isExpanded: false),
                                          ),
                                        ),
                                        if (_homeCubit
                                                .state.itens?.isNotEmpty ??
                                            false)
                                          FeaturedItens(
                                            itens: _homeCubit
                                                .featuredItens(maxItens: 6)
                                                .where((element) =>
                                                    element.emphasis == true)
                                                .map(
                                                  (product) =>
                                                      ProductFeaturedItem(
                                                    key: UniqueKey(),
                                                    backgroundImage:
                                                        product.image.first,
                                                    title: product.name,
                                                    price: product.value,
                                                    onTap: () =>
                                                        BottomSheetModal.show(
                                                      context: context,
                                                      content: ProductDetails(
                                                        product: product,
                                                      ),
                                                    ),
                                                    onTapCart: () => _cartCubit
                                                        .addCartProduct(
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
                                        SizedBox(height: 8.height),
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
                                      bottom: PreferredSize(
                                        preferredSize:
                                            const Size.fromHeight(50.0),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              bottom: 0,
                                              left: 16.width,
                                              right: 16.width,
                                              child: Container(
                                                height: 2,
                                                color: design.secondary100,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                height: 40,
                                                child: TabBar(
                                                  indicatorWeight: 2,
                                                  controller: _tabController,
                                                  labelColor: design.primary100,
                                                  indicatorColor:
                                                      design.primary100,
                                                  unselectedLabelColor:
                                                      design.secondary100,
                                                  isScrollable: true,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.width,
                                                  ),
                                                  tabs: state.categories
                                                          ?.map(
                                                              (category) => Tab(
                                                                    text: category
                                                                        .name
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
                  ),
                  floatingActionButton: _buttonNextCurrentPage
                      ? FloatingButtonCurrentPage(controller: _tabController)
                      : null,
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
