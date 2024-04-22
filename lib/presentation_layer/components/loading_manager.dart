import 'package:flutter/material.dart';

mixin LoadingManager {
  void handleLoadingOverlay(
    Stream<bool> stream,
    BuildContext context,
  ) =>
      stream.listen(
        (show) =>
            show ? showLoadingOverlay(context) : hideLoadingOverlay(context),
      );

  void showLoadingOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: const Color(0xFF212332).withOpacity(.5),
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void hideLoadingOverlay(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
