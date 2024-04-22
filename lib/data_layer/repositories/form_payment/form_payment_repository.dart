import 'package:quickfood/domain_layer/domain_layer.dart';
import 'package:quickfood/data_layer/data_layer.dart';

import 'package:quickfood/infra/infra.dart';

class FormPaymentRepository implements FormPaymentRepositoryInterface {
  final FormPaymentDataSource _dataSource;

  FormPaymentRepository({
    required FormPaymentDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Result<List<FormPaymentDTO>?>> getFormPayment() async {
    return await _dataSource.getFormPayment();
  }
}
