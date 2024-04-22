import 'package:uuid/uuid.dart';

import 'package:quickfood/domain_layer/domain_layer.dart';

class FormPaymentDTO extends FormPaymentEntity {
  FormPaymentDTO({
    super.id,
    required super.name,
  }) {
    var uuid = const Uuid();
    id = id ?? uuid.v4();
  }

  FormPaymentDTO copyWith({
    String? id,
    String? name,
  }) {
    return FormPaymentDTO(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory FormPaymentDTO.fromJson(Map<String, dynamic> map) {
    return FormPaymentDTO(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] as String,
    );
  }
}
