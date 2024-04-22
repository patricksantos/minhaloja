import 'package:quickfood/data_layer/data_layer.dart';
import 'package:quickfood/infra/infra.dart';

abstract class FormPaymentRepositoryInterface {
  Future<Result<List<FormPaymentDTO>?>> getFormPayment();
}
