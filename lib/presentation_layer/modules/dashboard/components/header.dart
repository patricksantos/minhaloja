import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cubit/dashboard_cubit.dart';

import '../constants.dart';
import '../../../../infra/infra.dart';

class Header extends StatelessWidget {
  final String titlePage;
  final _controller = Modular.get<DashboardCubit>();

  Header({
    Key? key,
    required this.titlePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!ResponsiveScreen.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.white,
            onPressed: _controller.controlMenu,
          ).addPadding(
            const EdgeInsets.only(right: 15),
          ),
        if (!ResponsiveScreen.isMobile(context))
          Text(
            titlePage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!ResponsiveScreen.isMobile(context))
          Spacer(flex: ResponsiveScreen.isDesktop(context) ? 2 : 1),
        const Expanded(child: SearchField()),
        ProfileCard(
          userName: _controller.state.restaurant?.name ?? '',
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String userName;

  const ProfileCard({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding / 2),
      padding: const EdgeInsets.all(defaultPadding * 0.8),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // Image.asset(
          //   "assets/icon/restaurant.png",
          //   height: 28,
          // ),
          const Icon(
            Icons.store,
            color: Colors.white,
          ),
          if (!ResponsiveScreen.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(userName),
            ),
          // const Icon(
          //   Icons.keyboard_arrow_down,
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: const Text(
          "   Pesquisar",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        alignLabelWithHint: false,
        fillColor: secondaryColor,
        filled: true,
        // focusColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
