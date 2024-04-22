import 'package:minhaloja/data_layer/data_layer.dart';
import 'package:minhaloja/domain_layer/domain_layer.dart';

import 'package:minhaloja/infra/infra.dart';

class GetFormPaymentUseCase {
  final FormPaymentRepositoryInterface _repository;

  GetFormPaymentUseCase({
    required FormPaymentRepositoryInterface repository,
  }) : _repository = repository;

  Future<Result<List<FormPaymentDTO>?>> call() async {
    return await _repository.getFormPayment();
  }
}
