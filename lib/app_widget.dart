import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quickfood/infra/infra.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return DesignSystem(
      foodAppDesign: foodAppDesign,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              if (ResponsiveScreen.isDesktop(context)) {
                SizeConfig(
                  designScreenWidth: 1024,
                  designScreenHeight: 768,
                ).init(constraints, orientation);
              }
              if (ResponsiveScreen.isTablet(context)) {
                SizeConfig(
                  designScreenWidth: 1280,
                  designScreenHeight: 800,
                ).init(constraints, orientation);
              }
              if (ResponsiveScreen.isMobile(context)) {
                SizeConfig(
                  designScreenWidth: 375,
                  designScreenHeight: 812,
                ).init(constraints, orientation);
              }
              return MaterialApp.router(
                title: 'Eatsy',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: foodAppDesign.primary300,
                  textTheme:
                      GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                          .apply(bodyColor: foodAppDesign.white),
                ),
                routerDelegate: Modular.routerDelegate,
                routeInformationParser: Modular.routeInformationParser,
                // supportedLocales: const [
                //   Locale('en', 'US'),
                //   Locale('pt', 'BR'),
                // ],
              );
            },
          );
        },
      ),
    );
  }
}
