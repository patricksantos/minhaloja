// ignore_for_file: public_member_api_docs, sort_constructors_first
class ComboEntity {
  final String name;
  final double value;
  final bool isSelected;

  ComboEntity({
    required this.name,
    required this.value,
    this.isSelected = false,
  });

  ComboEntity copyWith({
    String? name,
    double? value,
    bool? isSelected,
  }) {
    return ComboEntity(
      name: name ?? this.name,
      value: value ?? this.value,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
