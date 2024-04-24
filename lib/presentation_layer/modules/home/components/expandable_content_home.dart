import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:minhaloja/infra/infra.dart';

class ExpandableContentHome extends StatefulWidget {
  final String restaurantId;
  final String userId;

  const ExpandableContentHome({
    super.key,
    required this.restaurantId,
    required this.userId,
  });

  @override
  State<ExpandableContentHome> createState() => _ExpandableContentHomeState();
}

class _ExpandableContentHomeState extends State<ExpandableContentHome>
    with TickerProviderStateMixin {
  late CartCubit _cartCubit;

  late TabController _tabController;
  late ScrollController _controller;

  int _currentPage = 0;
  List<String> categories = ['Carrinho'];

  @override
  void initState() {
    super.initState();
    _cartCubit = Modular.get<CartCubit>();

    _controller = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.index != _currentPage) {
        setState(() {
          _currentPage = _tabController.index;
        });
      }
    });
    setState(() {
      _currentPage = _cartCubit.state.productListCart.isEmpty ? 1 : 0;
      _tabController.index = _cartCubit.state.productListCart.isEmpty ? 1 : 0;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocConsumer<CartCubit, CartState>(
      bloc: _cartCubit,
      listener: (context, state) {
        setState(() {
          _currentPage = state.productListCart.isEmpty ? 1 : 0;
          _tabController.index = state.productListCart.isEmpty ? 1 : 0;
        });
      },
      builder: (_, state) {
        return DefaultTabController(
          initialIndex: _currentPage,
          length: categories.length,
          child: Container(
            color: design.white,
            height: MediaQuery.of(context).size.height * .95 - 70,
            child: NestedScrollView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) =>
                  [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  toolbarHeight: 0,
                  elevation: 0,
                  backgroundColor: design.white,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TabBar(
                              tabAlignment: TabAlignment.start,
                              indicatorWeight: 2,
                              dividerColor: Colors.transparent,
                              controller: _tabController,
                              labelColor: design.primary100,
                              indicatorColor: design.primary100,
                              unselectedLabelColor: design.secondary100,
                              isScrollable: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.width,
                              ),
                              tabs: [
                                Tab(text: categories[0].toCapitalized()),
                                Tab(text: categories[1].toCapitalized()),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.width),
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  // CartProductsModule(
                  //   restaurantId: widget.restaurantId,
                  //   userId: widget.userId,
                  //   isExpanded: true,
                  // ),
                  // OrderModule(
                  //   isExpanded: true,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
