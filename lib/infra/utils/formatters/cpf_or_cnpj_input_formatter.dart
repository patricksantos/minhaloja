import 'cnpj_input_formatter.dart';
import 'cpf_input_formatter.dart';
import 'multiple_formatters.dart';

class CpfOrCnpjFormatter extends CompoundFormatter {
  CpfOrCnpjFormatter()
      : super([
          CpfInputFormatter(),
          CnpjInputFormatter(),
        ]);
}
