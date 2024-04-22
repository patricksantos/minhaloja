import 'package:flutter/material.dart';

class SizeConfig {
  SizeConfig({
    required this.designScreenWidth,
    required this.designScreenHeight,
  });

  /// valor da [largura da tela] do projeto dado pelo [designer]
  int designScreenWidth;

  /// valor da [altura da tela] do projeto dado pelo [designer]
  int designScreenHeight;

  /// [largura] da tela atual
  static double? _screenWidth;

  /// [altura] da tela atual
  static double? _screenHeight;

  /// valor de inicialização do [tamanho da fonte]
  static double? textMultiplier;

  /// valor de inicialização do [tamanho da imagem]
  static double? imageSizeMultiplier;

  /// valor de inicialização da [altura]
  static double? heightMultiplier;

  /// valor de inicialização da [largura]
  static double? widthMultiplier;

  /// valor para obter informações sobre [orientação]
  static bool isPortrait = true;

  /// valor para obter informações se está em modo [retrato] no [celular] ou [não]
  static bool isMobilePortrait = false;

  /// método para inicializar [SizeConfig] com cálculo responsivo
  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    imageSizeMultiplier =
        heightMultiplier = (_screenHeight! / designScreenHeight);
    widthMultiplier = textMultiplier = (_screenWidth! / designScreenWidth);
  }
}
