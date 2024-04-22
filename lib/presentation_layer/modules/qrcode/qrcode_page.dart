import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../presentation_layer/modules/qrcode/components/qr_overlay.dart';
import 'package:quickfood/data_layer/data_layer.dart';

import 'package:quickfood/infra/infra.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  late MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
      returnImage: false,
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(PathImages.iconRestaurant),
              ),
            ),
            child: MobileScanner(
              controller: _scannerController,
              // fit: BoxFit.cover,
              onDetect: (barcode) {
                final code = barcode.raw;
                var str =
                    code['rawValue'].toString().replaceAll("'", "\"").trim();
                var encodedString = jsonDecode(str);
                var qrcode = QrCodeDTO.fromJson(encodedString);
                debugPrint(
                    'Barcode found! ${QrCodeDTO.fromJson(encodedString).toJson()}');

                if (qrcode.store == '') {
                  context.showSnackBar(
                    message: 'Restaurante nāo encontrado',
                    backgroundColor: design.terciary200,
                  );
                } else {
                  context.showSnackBar(
                    message:
                        'Redirecionando para o restaurante ${qrcode.store.toCapitalized()}',
                  );
                  _scannerController.stop();
                  Modular.to.popAndPushNamed(PageRoutes.home + qrcode.store);
                }
              },
            ),
          ),
          QRScannerOverlay(
            overlayColour: Colors.black.withOpacity(0.8),
            controller: _scannerController,
          ),
        ],
      ),
    );
  }
}
