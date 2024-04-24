import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'firebase_options.dart';

import '../app_module.dart';
import '../app_widget.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Future.delayed(const Duration(seconds: 1), () {
  //   FlutterNativeSplash.remove();
  // });
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final emulatorHost =
  //     (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
  //         ? '10.0.2.2'
  //         : 'localhost';
  // await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
