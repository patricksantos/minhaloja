import 'package:minhaloja/infra/utils.dart';

/// Extensão para usar valores usando [num]
extension Responsive on num {
  /// [getter] para obter [altura responsiva] de acordo com a altura do dispositivo para margin, padding e sizedbox
  double get height => SizeConfig.heightMultiplier! * this;

  /// [getter] para obter [largura responsiva] de acordo com a largura do dispositivo para margin, padding and sized box
  double get width => SizeConfig.widthMultiplier! * this;

  /// [getter] para obter [tamanho de fonte] de acordo com a largura do dispositivos para icons e fontSize
  double get fontSize => SizeConfig.textMultiplier! * this;
}
