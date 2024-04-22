import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/infra/infra.dart';

abstract class FormPaymentRepositoryInterface {
  Future<Result<List<FormPaymentDTO>?>> getFormPayment();
}
