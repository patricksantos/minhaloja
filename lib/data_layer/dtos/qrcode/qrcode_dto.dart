import 'package:minhaloja/domain_layer/domain_layer.dart';

class QrCodeDTO extends QrCodeEntity {
  QrCodeDTO({
    required super.store,
    required super.place,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'store': store,
      'place': place,
    };
  }

  factory QrCodeDTO.fromJson(Map<String, dynamic> map) {
    return QrCodeDTO(
      store: map['store'] as String,
      place: map['place'] as String,
    );
  }
}
