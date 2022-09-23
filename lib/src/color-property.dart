part of setalpha;

/// An abstract convenience class for determining
/// various properties of colors.
///
abstract class ColorProperty {
  /// The red-green-blue proportion components of [color].
  static List<double> rgbProportions(String color) =>
      [...rgba(color).sublist(0, 3).map((c) => c / 255.0)];

  static List<num> rgba(String color) {
    final hex = setAlpha(color).substring(1);
    return List.generate(
        4, (i) => int.parse(hex.substring(i * 2, (i + 1) * 2), radix: 16));
  }

  static num _p(num p) => (p * 10000).round() / 100;

  /// The red component of [color].
  static num red(String color) => rgba(color)[0];

  /// The red proportion component of [color].
  static num redAsProportion(String color) => rgbProportions(color)[0];

  /// The red proportion component of [color], expressed
  /// as a percentage.
  static num redAsPercent(String color) => _p(redAsProportion(color));

  /// The green component of [color].
  static num green(String color) => rgba(color)[1];

  /// The green proportion component of [color].
  static num greenAsProportion(String color) => rgbProportions(color)[1];

  /// The green proportion component of [color], expressed
  /// as a percentage.
  static num greenAsPercent(String color) => _p(greenAsProportion(color));

  /// The blue component of [color].
  static num blue(String color) => rgba(color)[2];

  /// The blue proportion component of [color].
  static num blueAsProportion(String color) => rgbProportions(color)[2];

  /// The blue proportion component of [color], expressed
  /// as a percentage.
  static num blueAsPercent(String color) => _p(blueAsProportion(color));

  /// The alpha level of [color].
  static num alpha(color) => rgba(color)[3] / 255;

  /// The intensity, or mean proportion component, of [color].
  static num intensity(String color) =>
      rgbProportions(color).fold(0.0, (a, b) => a + b) / 3;

  /// The intensity, or mean proportion component, of [color],
  /// expressed as a percentage.
  static num intensityAsPercent(String color) => _p(intensity(color));

  /// The maximum proportion component of [color].
  static num max(String color) =>
      rgbProportions(color).reduce((a, b) => a > b ? a : b);

  /// The maximum proportion component of [color], expressed
  /// as a percentage.
  static num maxAsPercent(String color) => _p(max(color));

  /// The minimum proportion component of [color].
  static num min(String color) =>
      rgbProportions(color).reduce((a, b) => a < b ? a : b);

  /// The minimum proportion component of [color], expressed
  /// as a percentage.
  static num minAsPercent(String color) => _p(min(color));

  /// The chroma, or range of proportion components, of [color].
  static num chroma(String color) => max(color) - min(color);

  /// The chroma, or range of proportion components, of [color].
  static num chromaAsPercent(String color) => _p(chroma(color));

  /// The lightness, or mean of the proportion component optima,
  /// of [color].
  static num lightness(String color) => (max(color) + min(color)) / 2;

  /// The lightness, or mean of the proportion component optima,
  /// of [color], expresses as a percent.
  static num lightnessAsPercent(String color) => _p(lightness(color));

  /// The luma, or mean proportion component weighted by
  /// human perception of lightness, of [color].
  static num luma(String color) {
    final components = rgbProportions(color);
    return List.generate(3, (i) => components[i] * [0.299, 0.587, 0.114][i])
        .fold(0, (a, b) => a + b);
  }

  /// The luma, or mean proportion component weighted by
  /// human perception of lightness, of [color], expressed
  /// as a percentage.
  static num lumaAsPercent(String color) => _p(luma(color));

  static num? _h(String color) {
    final c = chroma(color);
    if (c == 0) return null;
    final m = max(color);

    if (m == redAsProportion(color)) {
      return ((greenAsProportion(color) - blueAsProportion(color)) / c) % 6;
    }

    if (m == greenAsProportion(color)) {
      return (blueAsProportion(color) - redAsProportion(color)) / c + 2;
    }

    return (redAsProportion(color) - greenAsProportion(color)) / c + 4;
  }

  /// The hsl hue, or direction, of [color], in degrees.
  static num? hueInDegrees(String color) {
    final h = _h(color);
    if (h == null) return null;
    return 60 * h;
  }

  /// The hsl saturation of [color].
  static num saturation(String color) {
    final l = lightness(color);
    if (l == 0 || l == 1) return 0;
    return chroma(color) / (1 - (2 * l - 1).abs());
  }

  /// The hsl saturation of [color], expressed as a percentage.
  static num saturationAsPercent(String color) => _p(saturation(color));
}
