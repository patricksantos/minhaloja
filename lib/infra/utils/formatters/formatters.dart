import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final maskFormatterAccountNumber = MaskTextInputFormatter(
  mask: '######-#',
  filter: {'#': RegExp(r'[0-9]')},
);

// final maskFormatterCpf = MaskTextInputFormatter(
//   mask: '###.###.###-##',
//   filter: {'#': RegExp(r'[0-9]')},
// );

// final maskFormatterCnpj = MaskTextInputFormatter(
//   mask: '##.###.###/####-##',
//   filter: {'#': RegExp(r'[0-9]')},
// );

final maskFormatterDate = MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {'#': RegExp(r'[0-9]')},
);

// final maskFormatterPhoneNumber = MaskTextInputFormatter(
//   mask: '(##) # ####-####',
//   filter: {'#': RegExp(r'[0-9]')},
// );

final onlyAlphabeticalFormatter = FilteringTextInputFormatter.allow(
  RegExp('[\\sa-zA-Z]'),
);

final onlyCharactersFormatter = FilteringTextInputFormatter.allow(
  RegExp('[\\s0-9a-zA-Z]'),
);

// CurrencyTextInputFormatter createMoneyFormatter({
//   int decimalDigits = 2,
//   String locale = 'pt-BR',
//   String symbol = '',
// }) {
//   return CurrencyTextInputFormatter(
//     decimalDigits: decimalDigits,
//     locale: locale,
//     symbol: symbol,
//   );
// }

MaskTextInputFormatter maskFormatterCep() => MaskTextInputFormatter(
      mask: '#####-###',
      filter: {'#': RegExp(r'[0-9]')},
    );

MaskTextInputFormatter maskFormatterPhoneNumber() => MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: {'#': RegExp(r'[0-9]')},
    );

MaskTextInputFormatter maskFormatterCpf() => MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {'#': RegExp(r'[0-9]')},
    );

MaskTextInputFormatter maskFormatterCnpj() => MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: {'#': RegExp(r'[0-9]')},
    );

TextInputFormatter maskFormatterBarCode() => MaskTextInputFormatter(
      mask: '###########-# ###########-# ###########-# ###########-#',
      filter: {'#': RegExp(r'[0-9]')},
    );

FilteringTextInputFormatter makeOnlyAlphabeticalFormatter() =>
    FilteringTextInputFormatter.allow(
      RegExp('[\\sa-zA-ZÀ-ÿ]'),
    );

FilteringTextInputFormatter makeOnlyCharactersFormatter() =>
    FilteringTextInputFormatter.allow(
      RegExp('[\\s0-9a-zA-ZÀ-ÿ]'),
    );

String maskTextBarCode(String text) => MaskTextInputFormatter(
      initialText: text,
      mask: '###########-# ###########-# ###########-# ###########-#',
      filter: {'#': RegExp(r'[0-9]')},
    ).getMaskedText();

String maskEmail(String email) {
  List<String> parts = email.split('@');
  if (parts.length != 2) {
    return email;
  }
  String local = parts[0];
  String domain = parts[1];

  String maskedLocal = '${local.substring(0, 3)}******';

  return '$maskedLocal@$domain';
}
