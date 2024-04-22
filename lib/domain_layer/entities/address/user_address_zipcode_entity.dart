class UserAddressByZipCodeEntity {
  final String state;
  final String city;
  final String street;
  final String neighborhood;
  final String zipCode;
  final String complement;

  const UserAddressByZipCodeEntity({
    required this.state,
    required this.city,
    required this.street,
    required this.neighborhood,
    required this.zipCode,
    required this.complement,
  });
}
