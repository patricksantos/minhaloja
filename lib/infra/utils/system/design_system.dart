import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils.dart';

class DesignSystem extends InheritedWidget {
  final FoodAppDesign foodAppDesign;

  const DesignSystem({
    Key? key,
    required this.foodAppDesign,
    required Widget child,
  }) : super(key: key, child: child);

  static FoodAppDesign of(BuildContext context) {
    final layerDesign = context
        .dependOnInheritedWidgetOfExactType<DesignSystem>()
        ?.foodAppDesign;

    assert(layerDesign != null, 'No FoodAppDesign found in context.');

    return layerDesign!;
  }

  @override
  bool updateShouldNotify(DesignSystem oldWidget) {
    return foodAppDesign != oldWidget.foodAppDesign;
  }
}

/// Example class
class FoodAppDesign {
  /// [Colors] - Defined on `Figma`

  /// [Primary Color]
  final Color primary100;
  final Color primary200;
  final Color primary300;

  /// [Secondary Color]
  final Color secondary100;
  final Color secondary200;
  final Color secondary300;

  /// [Terciary Color]
  final Color terciary100;
  final Color terciary200;
  final Color terciary300;

  /// [White]
  final Color white;

  /// [Grey]
  final Color gray;

  /// [Text styles / Typography] - Defined on `Figma`
  /// Defaults to `Figtree`
  final String fontFamily;

  /// [Headings]
  final TextStyle _heading1;
  final TextStyle _heading2;
  final TextStyle _heading3;
  final TextStyle _heading4;
  final TextStyle _heading5;
  final TextStyle _heading6;

  /// [Subtitle, Paragraph, Caption]
  final TextStyle _subtitle;
  final TextStyle _labelMedium;
  final TextStyle _labelSmall;
  final TextStyle _paragraphMedium;
  final TextStyle _paragraphSmall;
  final TextStyle _caption;

  const FoodAppDesign({
    this.fontFamily = 'Poppins',
    required this.primary100,
    required this.primary200,
    required this.primary300,
    required this.secondary100,
    required this.secondary200,
    required this.secondary300,
    required this.terciary100,
    required this.terciary200,
    required this.terciary300,
    required this.white,
    required this.gray,
    required TextStyle heading1,
    required TextStyle heading2,
    required TextStyle heading3,
    required TextStyle heading4,
    required TextStyle heading5,
    required TextStyle heading6,
    required TextStyle subtitle,
    required TextStyle labelMedium,
    required TextStyle labelSmall,
    required TextStyle paragraphMedium,
    required TextStyle paragraphSmall,
    required TextStyle caption,
  })  : _heading1 = heading1,
        _heading2 = heading2,
        _heading3 = heading3,
        _heading4 = heading4,
        _heading5 = heading5,
        _heading6 = heading6,
        _subtitle = subtitle,
        _labelMedium = labelMedium,
        _labelSmall = labelSmall,
        _paragraphMedium = paragraphMedium,
        _paragraphSmall = paragraphSmall,
        _caption = caption;

  FoodAppDesign copyWith({
    Color? primary100,
    Color? primary200,
    Color? primary300,
    Color? secondary100,
    Color? secondary200,
    Color? secondary300,
    Color? terciary100,
    Color? terciary200,
    Color? terciary300,
    Color? white,
    Color? gray,
    LinearGradient? gradient,
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? heading3,
    TextStyle? heading4,
    TextStyle? heading5,
    TextStyle? heading6,
    TextStyle? subtitle,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? paragraphMedium,
    TextStyle? paragraphSmall,
    TextStyle? caption,
  }) {
    return FoodAppDesign(
      primary100: primary100 ?? this.primary100,
      primary200: primary200 ?? this.primary200,
      primary300: primary300 ?? this.primary300,
      secondary100: secondary100 ?? this.secondary100,
      secondary200: secondary200 ?? this.secondary200,
      secondary300: secondary300 ?? this.secondary300,
      terciary100: terciary100 ?? this.terciary100,
      terciary200: terciary200 ?? this.terciary200,
      terciary300: terciary300 ?? this.terciary300,
      white: white ?? this.white,
      gray: gray ?? this.gray,
      heading1: heading1 ?? _heading1,
      heading2: heading2 ?? _heading2,
      heading3: heading3 ?? _heading3,
      heading4: heading4 ?? _heading4,
      heading5: heading5 ?? _heading5,
      heading6: heading6 ?? _heading6,
      subtitle: subtitle ?? _subtitle,
      labelMedium: labelMedium ?? _labelMedium,
      labelSmall: labelSmall ?? _labelSmall,
      paragraphMedium: paragraphMedium ?? _paragraphMedium,
      paragraphSmall: paragraphSmall ?? _paragraphSmall,
      caption: caption ?? _caption,
    );
  }

  /// [Headings]
  TextStyle h1({Color? color}) => _getStyle(_heading1, color);

  TextStyle h2({Color? color}) => _getStyle(_heading2, color);

  TextStyle h3({Color? color}) => _getStyle(_heading3, color);

  TextStyle h4({Color? color}) => _getStyle(_heading4, color);

  TextStyle h5({Color? color}) => _getStyle(_heading5, color);

  TextStyle h6({Color? color}) => _getStyle(_heading6, color);

  /// [Subtitle, Paragraph, Caption]
  TextStyle subtitle({Color? color}) => _getStyle(_subtitle, color);

  TextStyle labelM({Color? color}) => _getStyle(_labelMedium, color);

  TextStyle labelS({Color? color}) => _getStyle(_labelSmall, color);

  TextStyle paragraphM({Color? color}) => _getStyle(_paragraphMedium, color);

  TextStyle paragraphS({Color? color}) => _getStyle(_paragraphSmall, color);

  TextStyle caption({Color? color}) => _getStyle(_caption, color);

  TextStyle _getStyle(TextStyle style, Color? color) {
    return GoogleFonts.getFont(
      style.fontFamily ?? fontFamily,
      fontSize: style.fontSize!.fontSize,
      fontWeight: style.fontWeight,
      height: style.height,
      letterSpacing: style.letterSpacing,
      color: color ?? primary300,
    );
  }

  ThemeData buildThemeData() => ThemeData.from(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primary100,
          secondary: secondary100,
          tertiary: terciary100,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          error: Colors.black,
          onError: Colors.black,
          background: Colors.black,
          onBackground: Colors.black,
          surface: Colors.black,
          onSurface: Colors.black,
        ),
        textTheme: TextTheme(
          displayLarge: _heading1,
          displayMedium: _heading2,
          displaySmall: _heading3,
          headlineMedium: _heading4,
          headlineSmall: _heading5,
          titleLarge: _heading6,
          titleMedium: _subtitle,
          titleSmall: _labelMedium,
          bodyLarge: _paragraphMedium,
          bodyMedium: _paragraphSmall,
          bodySmall: _caption,
        ),
      ).copyWith(
        scaffoldBackgroundColor: white,
      );
}

/// An extension for easily setting the font height for a [TextStyle]
extension FontHeightExtension on TextStyle {
  /// Returns a copy of the [TextStyle] with the calculated font height.
  ///
  /// The value is calculated by dividing the [TextStyle] fontSize and the
  /// passed height value expressed in logica pixels (can be found in Figma).
  ///
  /// Example:
  ///   - fontSize: 32
  ///   - passed height: 36
  ///
  ///   return copyWith(height: 36/32);
  ///
  TextStyle fontHeight(double height) =>
      fontSize == null ? this : copyWith(height: height / fontSize!);
}
