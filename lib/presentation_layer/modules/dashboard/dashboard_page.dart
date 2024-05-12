import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/presentation_layer/components/loading_manager.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/constants.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/cubit/dashboard_state.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/pages/configuration_store/configuration_store.dart';
import './pages/dashboard/home_dashboard_page.dart';

import './components/components.dart';
import './pages/login/login_page.dart';

class DashboardPage extends StatefulWidget {
  final int page;

  const DashboardPage({
    super.key,
    this.page = 0,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with LoadingManager {
  late DashboardCubit _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<DashboardCubit>();
    _controller.setPage(widget.page);
    Future.delayed(Duration.zero, () => executeStreams(context));
  }

  void executeStreams(BuildContext context) {
    handleLoadingOverlay(_controller.loadingStream.stream, context);
  }

  Widget pages(num page) {
    switch (page) {
      case 0:
        return const HomeDashboardPage();
      case 1:
        return const Text('Vendas');
      case 2:
        return const Text('Produtos');
      case 3:
        return const ConfigurationStore();
      default:
        return const HomeDashboardPage();
    }
  }

  String titlePages(num page) {
    switch (page) {
      case 0:
        return "Dashboard";
      case 1:
        return "Vendas";
      case 2:
        return "Produtos";
      case 3:
        return "Configurações";
      default:
        return "Dashboard";
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      key: UniqueKey(),
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _bodyDashboard();
        } else {
          return const LoginPage();
        }
      },
    );
  }

  Widget _bodyDashboard() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: _controller,
      builder: (context, state) {
        // if (state.isFirstAccess) {
        //   return const NewStore();
        // }
        return Scaffold(
          key: _controller.scaffoldKey,
          backgroundColor: bgColor,
          drawer: SideMenu(
            imagePath: state.restaurant?.logoUrl,
          ),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (ResponsiveScreen.isDesktop(context))
                  Expanded(
                    // default flex = 1
                    // and it takes 1/6 part of the screen
                    child: SideMenu(
                      imagePath: state.restaurant?.logoUrl,
                    ),
                  ),
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: SingleChildScrollView(
                    primary: false,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Header(
                          titlePage: titlePages(
                            _controller.state.page,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        pages(_controller.state.page),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
