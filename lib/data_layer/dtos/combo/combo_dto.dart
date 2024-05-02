import 'package:minhaloja/domain_layer/entities/combo/combo_entity.dart';

class ComboDTO extends ComboEntity {
  ComboDTO({
    required super.name,
    required super.value,
    super.isSelected = false,
  });

  @override
  ComboDTO copyWith({
    String? name,
    double? value,
    bool? isSelected,
  }) {
    return ComboDTO(
      name: name ?? this.name,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name.toString(),
      'value': value,
      'isSelected': isSelected,
    };
  }

  factory ComboDTO.fromJson(Map<String, dynamic> map) {
    return ComboDTO(
      name: map['name'] as String,
      value: map['value'] as double,
    );
  }

  @override
  String toString() =>
      'ComboDTO(name: $name, value: $value, isSelected: $isSelected)';
}
