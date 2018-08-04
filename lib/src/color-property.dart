part of setalpha;

/// An abstract convenience class for determining
/// various properties of colors.
///
abstract class ColorProperty {
  /// The red-green-blue proportion components of [color].
  static List<double> rgbProportions(String color) =>
      rgb(color).map((c) => c / 255.0).toList();

  static List<num> rgb(String color) {
    var hex = setAlpha(color).substring(1, 7);
    return List.generate(
        3, (i) => int.parse(hex.substring(i * 2, (i + 1) * 2), radix: 16));
  }

  static num _p(num p) => (p * 10000).round() / 100;

  /// The red proportion component of [color].
  static num red(String color) => rgbProportions(color)[0];

  /// The red proportion component of [color], expressed
  /// as a percentage.
  static num redAsPercent(String color) => _p(red(color));

  /// The green proportion component of [color].
  static num green(String color) => rgbProportions(color)[1];

  /// The green proportion component of [color], expressed
  /// as a percentage.
  static num greenAsPercent(String color) => _p(green(color));

  /// The blue proportion component of [color].
  static num blue(String color) => rgbProportions(color)[2];

  /// The blue proportion component of [color], expressed
  /// as a percentage.
  static num blueAsPercent(String color) => _p(blue(color));

  /// The intensity, or mean proportion component, of [color].
  static num intensity(String color) =>
      rgbProportions(color).fold(0, (a, b) => a + b) / 3;

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
    var components = rgbProportions(color);
    return List.generate(3, (i) => components[i] * [0.299, 0.587, 0.114][i])
        .fold(0, (a, b) => a + b);
  }

  /// The luma, or mean proportion component weighted by
  /// human perception of lightness, of [color], expressed
  /// as a percentage.
  static num lumaAsPercent(String color) => _p(luma(color));

  static num _h(String color) {
    var c = chroma(color);
    if (c == 0) return null;
    var m = max(color);

    if (m == red(color)) return ((green(color) - blue(color)) / c) % 6;

    if (m == green(color)) return (blue(color) - red(color)) / c + 2;

    return (red(color) - green(color)) / c + 4;
  }

  /// The hsl hue, or direction, of [color], in degrees.
  static num hueInDegrees(String color) {
    var h = _h(color);
    if (h == null) return null;
    return 60 * h;
  }

  /// The hsl saturation of [color].
  static num saturation(String color) {
    var l = lightness(color);
    if (l == 0 || l == 1) return 0;
    return chroma(color) / (1 - (2 * l - 1).abs());
  }

  /// The hsl saturation of [color], expressed as a percentage.
  static num saturationAsPercent(String color) => _p(saturation(color));
}
