import 'package:flutter/widgets.dart'
    show FormFieldValidator, TextEditingController;
// import 'package:jiffy/jiffy.dart';

import '../../infra.dart';

const List<String> _blockList = [
  '00000000000',
  '11111111111',
  '22222222222',
  '33333333333',
  '44444444444',
  '55555555555',
  '66666666666',
  '77777777777',
  '88888888888',
  '99999999999',
  '12345678909'
];
const List<String> _ufList = [
  'AC',
  'AL',
  'AP',
  'AM',
  'BA',
  'CE',
  'DF',
  'ES',
  'GO',
  'MA',
  'MT',
  'MS',
  'MG',
  'PA',
  'PB',
  'PR',
  'PE',
  'PI',
  'RJ',
  'RN',
  'RS',
  'RO',
  'RR',
  'SC',
  'SP',
  'SE',
  'TO'
];

abstract class Validators {
  Validators._();

  static FormFieldValidator<String> minAmount({
    String messageKey = 'Valor mínimo inválido',
    required double currentAmount,
    required double minAmount,
  }) {
    return (value) {
      if (currentAmount < minAmount) {
        return messageKey.replaceAll(
          '{value}',
          minAmount.formatWithCurrency(),
        );
      }
      return null;
    };
  }

  static FormFieldValidator<String> maxAmount({
    String messageKey = 'Valor máximo inválido',
    required double currentAmount,
    required double maxAmount,
  }) {
    return (value) {
      if (currentAmount > maxAmount) {
        return messageKey;
      }
      return null;
    };
  }

  static FormFieldValidator<String> uf(
      [String messageKey = 'Estado inválido']) {
    return (value) {
      if (!_ufList.contains(value)) {
        return messageKey;
      }
      return null;
    };
  }

  /// Validar um campo de telefone
  static FormFieldValidator<String> phone([
    String messageKey = 'Telefone inválido',
  ]) {
    return (value) {
      if (value?.isEmpty ?? true) return null;
      var reg = RegExp(r'^\([1-9]{2}\) (?:[2-8]|9[1-9])[0-9]{3}\-[0-9]{4}$');
      if (reg.hasMatch(value!)) return null;
      if (value.charAt(5) == '9') return null;
      return messageKey;
    };
  }

  /// Validar que o campo é [obrigatorio]
  /// Validators.required('Campo obrigatório')
  static FormFieldValidator<String> required([
    String messageKey = 'Campo Obrigatório',
  ]) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return messageKey;
      }
      return null;
    };
  }

  static FormFieldValidator<String> optional(Function(String?) validator) {
    return (value) {
      if (value?.isEmpty ?? true) {
        return null;
      }
      var result = validator(value);

      return result;
    };
  }

  /// Validar quantidade [minima] de caracteres no campo
  /// Validators.min(4, 'Mínimo 4 caracteres')
  static FormFieldValidator<String> min(
    int min, [
    String messageKey = '',
  ]) {
    messageKey = 'Minímo de $min caracteres';
    return (value) {
      if (value?.isEmpty ?? true) return null;
      if ((value?.length ?? 0) < min) {
        return messageKey.translate([min.toString()]);
      }
      return null;
    };
  }

  /// Validar quantidade [maxima] de caracteres no campo
  /// Validators.min(4, 'Máximo 4 caracteres')
  static FormFieldValidator<String> max(
    int max, [
    String messageKey = '',
  ]) {
    messageKey = 'Máximo de $max caracteres';
    return (value) {
      if (value?.isEmpty ?? true) return null;
      if ((value?.length ?? 0) > max) return messageKey;
      return null;
    };
  }

  /// Validar se o campo está entre
  /// a quantidade [minima] e [maxima] de caracteres
  /// Validators.between(6, 10, 'Senha deve conter entre 6 e 10 dígitos')
  static FormFieldValidator<String> between(
    int minimumLength,
    int maximumLength,
    String errorMessage,
  ) {
    assert(minimumLength < maximumLength);
    return multiple([
      min(minimumLength, errorMessage),
      max(maximumLength, errorMessage),
    ]);
  }

  /// Validar se todos os caracteres são [numeros]
  /// Validators.number('O valor não é número')
  static FormFieldValidator<String> number(String messageKey) {
    return (value) {
      if (value?.isEmpty ?? true) return null;
      if (double.tryParse(value!) != null) {
        return null;
      } else {
        return messageKey;
      }
    };
  }

  /// Validar se é um [email]
  /// Validators.email('E-mail inválido')
  static FormFieldValidator<String> email([
    String messageKey = 'Email inválido',
  ]) {
    return (value) {
      if (value?.isEmpty ?? true) return null;
      var emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      );
      if (emailRegex.hasMatch(value!)) return null;
      return messageKey;
    };
  }

  /// Validar se é um [cpf]
  /// Validators.cpf('CPF Inválido')
  static FormFieldValidator<String> cpf([
    String messageKey = 'CPF inválido',
  ]) {
    return (value) {
      if (value?.isEmpty ?? true) return null;
      if (CpfValidator.isValid(value!)) {
        return null;
      } else {
        return messageKey;
      }
    };
  }

  /// Validar se é um [cnpj]
  /// Validators.cnpj('CNPJ Inválido')
  static FormFieldValidator<String> cnpj({
    String messageKey = 'CNPJ inválido',
  }) {
    return (value) {
      if (value?.isEmpty ?? true) return null;
      if (CNPJValidator.isValid(value!)) {
        return null;
      } else {
        return messageKey;
      }
    };
  }

  /// Validar [varias] regras simultaneas
  /// Validators.multiple([
  ///   Validators.email('E-mail inválido')
  ///   Validators.max(4, 'Máximo 4 caracteres')
  /// ])
  static FormFieldValidator<String> multiple(
    List<FormFieldValidator<String>> values,
  ) {
    return (value) {
      for (var validator in values) {
        var result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }

  /// Validar se [data] é válida
  /// Validators.date('Data inválida')
  static FormFieldValidator<String> date([
    String messageKey = 'Data inválido',
  ]) {
    return (value) {
      if (value == null || value.isEmpty || value.length != 10) {
        return messageKey;
      }
      final components = value.split('/');
      if (components.length == 3) {
        final day = int.tryParse(components[0]);
        final month = int.tryParse(components[1]);
        final year = int.tryParse(components[2]);
        if (day != null && month != null && year != null) {
          final date = DateTime(year, month, day);
          final diffYear = DateTime.now().year - year;
          if (date.year == year &&
              date.month == month &&
              date.day == day &&
              diffYear <= 120) {
            return null;
          }
        }
      }
      return messageKey;
    };
  }

  /// Validar se [idade] do usuário é válida
  /// Validators.overAgeWorker('Data inválida')
  // static FormFieldValidator<String> overAge([
  //   String messageKey = 'Data inválido',
  // ]) {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return messageKey;
  //     }
  //     final validatedDate = date(messageKey)(value);
  //     if (validatedDate != null) {
  //       return validatedDate;
  //     }
  //     final birthDateFormat = Jiffy(value, 'dd/MM/yyyy').format('yyyy-MM-dd');
  //     if (DateTime.parse(birthDateFormat).isUnderage()) {
  //       return messageKey;
  //     }
  //     return null;
  //   };
  // }

  // static FormFieldValidator<String> denyFutureDate([
  //   String messageKey = 'Data inválido',
  // ]) {
  //   return (value) {
  //     if (value == null || value.isEmpty) {
  //       return messageKey;
  //     }
  //     final validatedDate = date(messageKey)(value);
  //     if (validatedDate != null) {
  //       return validatedDate;
  //     }
  //     final isAfterThatToday =
  //         Jiffy(value, 'dd/MM/yyyy').isAfter(DateTime.now());
  //     if (isAfterThatToday) {
  //       return messageKey;
  //     }
  //     return null;
  //   };
  // }

  /// [Comparar] dois campos
  /// Validators.compare(inputController, 'As senhas são diferentes')
  static FormFieldValidator<String> compare(
    TextEditingController? controller,
    String messageKey,
  ) {
    return (value) {
      var textCompare = controller?.text ?? '';
      if (value == null || textCompare != value) {
        return messageKey;
      }
      return null;
    };
  }
}

class CpfValidator {
  static const stripRegex = r'[^\d]';
  static int _verifierDigit(String cpf) {
    List<int> numbers =
        cpf.split('').map((number) => int.parse(number, radix: 10)).toList();
    int modulus = numbers.length + 1;
    List<int> multiplied = [];
    for (var i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }
    int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;
    return (mod < 2 ? 0 : 11 - mod);
  }

  static String strip(String cpf) {
    RegExp regExp = RegExp(stripRegex);
    return cpf.replaceAll(regExp, '');
  }

  static bool isValid(String cpf, [stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      cpf = strip(cpf);
    }
    if (cpf.isEmpty) {
      return false;
    }
    if (cpf.length != 11) {
      return false;
    }
    if (_blockList.contains(cpf)) {
      return false;
    }
    String numbers = cpf.substring(0, 9);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();
    return numbers.substring(numbers.length - 2) ==
        cpf.substring(cpf.length - 2);
  }

  static String format(String cpf) {
    RegExp regExp = RegExp(r'^(.{3})(.{3})(.{3})(.{2})$');

    return cpf.replaceAllMapped(
      regExp,
      (Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}',
    );
  }
}

class CNPJValidator {
  static const stripRegex = r'[^\d]';
  static int _verifierDigit(String cnpj) {
    int index = 2;
    List<int> reverse =
        cnpj.split('').map((s) => int.parse(s)).toList().reversed.toList();
    int sum = 0;
    for (var number in reverse) {
      sum += number * index;
      index = (index == 9 ? 2 : index + 1);
    }
    int mod = sum % 11;
    return (mod < 2 ? 0 : 11 - mod);
  }

  static String strip(String cnpj) {
    RegExp regex = RegExp(stripRegex);
    return cnpj.replaceAll(regex, '');
  }

  static bool isValid(String cnpj, [stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      cnpj = strip(cnpj);
    }
    if (cnpj.isEmpty) {
      return false;
    }
    if (cnpj.length != 14) {
      return false;
    }
    if (_blockList.contains(cnpj)) {
      return false;
    }
    String numbers = cnpj.substring(0, 12);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();
    return numbers.substring(numbers.length - 2) ==
        cnpj.substring(cnpj.length - 2);
  }

  static String format(String cnpj) {
    RegExp regExp = RegExp(r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$');

    return strip(cnpj).replaceAllMapped(
      regExp,
      (Match m) => '${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}',
    );
  }
}
