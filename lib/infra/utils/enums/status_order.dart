enum StatusOrder {
  none,
  confirmado,
  emPreparo,
  aCaminho,
  emAnalise,
  cancelado,
  pronto;

  bool isConfirmado() => this == StatusOrder.confirmado;
  bool isDelivery() => this == StatusOrder.emPreparo;
  bool isCaminho() => this == StatusOrder.aCaminho;
  bool isPronto() => this == StatusOrder.pronto;

  static StatusOrder create(String value) {
    return value == 'confirmado'
        ? StatusOrder.confirmado
        : value == 'emPreparo'
            ? StatusOrder.emPreparo
            : value == 'aCaminho'
                ? StatusOrder.aCaminho
                : value == 'pronto'
                    ? StatusOrder.pronto
                    : value == 'emAnalise'
                        ? StatusOrder.emAnalise
                        : StatusOrder.none;
  }
}
