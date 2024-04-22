import 'package:flutter_modular/flutter_modular.dart';

import 'cubit/qrcode_cubit.dart';
import 'qrcode_page.dart';

class QrCodeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => QrCodeCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const QrCodePage(),
    ),
  ];
}
