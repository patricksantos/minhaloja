import 'package:flutter/material.dart';

extension PageControllerExtension on PageController {
  void goNext() {
    nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }
}
