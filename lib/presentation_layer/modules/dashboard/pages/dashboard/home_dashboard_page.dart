import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/cubit/dashboard_state.dart';
import '../../cubit/dashboard_cubit.dart';

import 'package:minhaloja/infra/infra.dart';
import '../../components/components.dart';
import '../../constants.dart';

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  late DashboardCubit _controller;

  @override
  void initState() {
    _controller = Modular.get<DashboardCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final design = DesignSystem.of(context);
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: _controller,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const MyFiles(),
                      const SizedBox(height: defaultPadding),
                      const RecentFiles(),
                      if (ResponsiveScreen.isMobile(context))
                        const SizedBox(height: defaultPadding),
                      if (ResponsiveScreen.isMobile(context))
                        const StorageDetails(),
                    ],
                  ),
                ),
                if (!ResponsiveScreen.isMobile(context))
                  const SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!ResponsiveScreen.isMobile(context))
                  const Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            )
          ],
        );
      },
    );
  }
}
