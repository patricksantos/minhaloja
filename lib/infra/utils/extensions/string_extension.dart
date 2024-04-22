import 'package:localization/localization.dart';

extension StringExtensions on String {
  String translate([List<String> args = const []]) => i18n(args);
  String extractNumbers() => replaceAll(RegExp(r'\D'), '');

  String charAt(int position) {
    if (length <= position || length + position < 0) {
      return '';
    }

    var realPosition = position < 0 ? length + position : position;

    return this[realPosition];
  }

  double convertCurrencyToDouble() {
    if (isEmpty) {
      return 0;
    }
    final value = double.tryParse(
      replaceAll('R\$ ', '').replaceAll('.', '').replaceAll(',', '.'),
    );

    return value ?? 0;
  }

  String formatPhoneNumber() {
    if (length > 11) {
      return replaceAllMapped(
        RegExp(r'(\+\d{2})(\d{2})(\d{5})(\d+)'),
        (Match m) => '${m[1]} (${m[2]}) ${m[3]}-${m[4]}',
      );
    }
    return replaceAllMapped(
      RegExp(r'(\d{2})(\d{5})(\d+)'),
      (Match m) => '(${m[1]}) ${m[2]}-${m[3]}',
    );
  }

  List<String> splitByLength(int length) => [
        substring(0, length),
        substring(length),
      ];

  bool? toBool() {
    if (this == 'true') {
      return true;
    }
    if (this == 'false') {
      return false;
    }
    return null;
  }
}
