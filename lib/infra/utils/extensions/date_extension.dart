import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  bool isUnderage() =>
      (DateTime(DateTime.now().year, month, day).isAfter(DateTime.now())
          ? DateTime.now().year - year - 1
          : DateTime.now().year - year) <
      18;

  String getStringDate(
    String pattern, {
    required BuildContext context,
  }) {
    var dateFormatter = DateFormat(
      pattern,
      Localizations.localeOf(context).toString(),
    );
    return dateFormatter.format(this);
  }

  bool get isToday =>
      DateTime(
        year,
        month,
        day,
      ) ==
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
}
