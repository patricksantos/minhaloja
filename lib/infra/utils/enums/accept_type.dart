enum AcceptType {
  json,
  pdf;

  bool isJson() => this == AcceptType.json;
  bool isPdf() => this == AcceptType.pdf;
}
