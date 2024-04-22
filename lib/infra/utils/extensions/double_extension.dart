import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatWithCurrency({
    bool hideValue = false,
  }) {
    if (hideValue) {
      return '****';
    }

    final formatter = NumberFormat.currency(
      locale: 'pt_BR',
      decimalDigits: 2,
      name: 'BRL',
      symbol: '',
    );

    if (hideValue) {
      return formatter.format(this).replaceAll(
            RegExp(r'[a-zA-Z0-9,]'),
            '*',
          );
    }

    return formatter.format(this);
  }
}
