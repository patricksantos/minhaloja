class TBEndpoints {
  static String uuid(String uuid) => '/uuid/$uuid';
  static String addressByZipCode(String zipcode) =>
      'https://viacep.com.br/ws/$zipcode/json/';
}
