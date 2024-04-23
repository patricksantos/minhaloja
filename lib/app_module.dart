import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/data_layer/data_layer.dart';
import 'presentation_layer/modules.dart';

import 'package:minhaloja/infra/infra.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.lazySingleton((i) => HttpClient()),
    Bind.lazySingleton((i) => FirebaseFirestore.instance),
    Bind.lazySingleton((i) => FirebaseStorage.instance),
    Bind.lazySingleton((i) => FirebaseAuth.instance),
    Bind.lazySingleton((i) => StorageDataSource()),
    ...LoginModule.binds,
    ...AuthModule.binds,
    ...CartModule.binds,
    ...StoreModule.binds,
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
    ModuleRoute('/login', module: DashboardModule()),
    ModuleRoute('/dashboard', module: DashboardModule()),
    ModuleRoute('/qrcode', module: QrCodeModule()),
  ];
}
