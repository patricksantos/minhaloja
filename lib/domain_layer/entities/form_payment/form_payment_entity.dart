import 'package:uuid/uuid.dart';

class FormPaymentEntity {
  String? id;
  final String name;

  FormPaymentEntity({
    this.id,
    required this.name,
  }){
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }
}
