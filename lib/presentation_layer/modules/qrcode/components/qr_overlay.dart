import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:minhaloja/infra/infra.dart';

class QRScannerOverlay extends StatelessWidget {
  final MobileScannerController controller;

  const QRScannerOverlay({
    Key? key,
    required this.overlayColour,
    required this.controller,
  }) : super(key: key);

  final Color overlayColour;

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 330.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                overlayColour,
                BlendMode.srcOut,
              ), // This one will create the magic
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      backgroundBlendMode: BlendMode.dstOut,
                    ), // This one will handle background + difference out
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: scanArea,
                      width: scanArea,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CustomPaint(
                foregroundPainter: BorderPainter(),
                child: SizedBox(
                  width: scanArea + 25,
                  height: scanArea + 25,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.height),
        Text(
          'Seja Bem Vindo',
          style: design
              .h3(color: design.white)
              .copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          'Aponte a sua câmera para o\nQrCode do estabelecimento',
          style: design
              .h6(color: design.secondary300)
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   color: Colors.white,
            //   icon: ValueListenableBuilder(
            //     valueListenable: controller.torchState,
            //     builder: (context, state, child) {
            //       switch (state) {
            //         case TorchState.off:
            //           return const Icon(Icons.flash_off, color: Colors.grey);
            //         case TorchState.on:
            //           return const Icon(Icons.flash_on, color: Colors.yellow);
            //       }
            //     },
            //   ),
            //   iconSize: 32.0,
            //   onPressed: () => controller.toggleTorch(),
            // ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: controller.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => controller.switchCamera(),
            ),
          ],
        )
      ],
    );
  }
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()
            ..addOval(Rect.fromCircle(
                center: Offset(size.width - 44, size.height - 44), radius: 40))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}
