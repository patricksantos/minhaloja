import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/cubit/dashboard_cubit.dart';
import '../constants.dart';

class SideMenu extends StatelessWidget {
  final String? imagePath;
  SideMenu({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final _loginController = Modular.get<LoginCubit>();
  final _dashboardController = Modular.get<DashboardCubit>();

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Drawer(
      backgroundColor: secondaryColor,
      child: ListView(
        children: [
          if (imagePath == null)
            DrawerHeader(
              child: Icon(
                Icons.store,
                color: Colors.white,
                size: 90.fontSize,
              ),
            ),
          if (imagePath != null)
            DrawerHeader(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                height: 48,
                width: 48,
                child: CachedNetworkImage(
                  imageUrl: imagePath.toString(),
                  errorWidget: (context, url, error) {
                    return DrawerHeader(
                      child: Icon(
                        Icons.store,
                        color: Colors.white,
                        size: 90.fontSize,
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.bottomCenter,
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: design.white,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 1, // 2.5
                      ),
                    ),
                  ),
                ),
              ),
            ),
          DrawerListTile(
            title: "Início",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () => _dashboardController.setPage(0),
          ),
          DrawerListTile(
            title: "Vendas",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => _dashboardController.setPage(1),
          ),
          DrawerListTile(
            title: "Produtos",
            svgSrc: "assets/icons/menu_store.svg",
            press: () => _dashboardController.setPage(2),
          ),
          DrawerListTile(
            title: "Configurações",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => _dashboardController.setPage(3),
          ),
          DrawerListTile(
            title: "Sair",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () => _loginController.signOut(),
          ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: "assets/icons/menu_task.svg",
          //
          // ),
          // DrawerListTile(
          //   title: "Documents",
          //   svgSrc: "assets/icons/menu_doc.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Profile",
          //   svgSrc: "assets/icons/menu_profile.svg",
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 10.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white70,
        // colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
