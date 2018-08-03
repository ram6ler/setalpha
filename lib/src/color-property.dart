part of setalpha;

/// An abstract convenience class for determining
/// various properties of colors.
///
abstract class ColorProperty {
  /// The red-green-blue proportion components of [color].
  /// TODO:
  static List<double> rgbProportions(String color) =>
      rgb(color).map((c) => c / 255.0).toList();

  static List<num> rgb(String color) {
    var hex = setAlpha(color).substring(1, 7);
    return List.generate(
        3, (i) => int.parse(hex.substring(i * 2, (i + 1) * 2), radix: 16));
  }

  /// The red proportion component of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.red(Color.turquoise));
  ///     // 0.25098039215686274
  ///
  static num redProportion(String color) => rgbProportions(color)[0];

  /// The green proportion component of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.green(Color.turquoise));
  ///     // 0.8784313725490196
  ///
  static num greenProportion(String color) => rgbProportions(color)[1];

  /// The blue proportion component of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.blue(Color.turquoise));
  ///     // 0.8156862745098039
  ///
  static num blueProportion(String color) => rgbProportions(color)[2];

  /// The intensity, or mean proportion component, of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.intensity(Color.turquoise));
  ///     // 0.6483660130718955
  ///
  static num intensity(String color) =>
      rgbProportions(color).fold(0, (a, b) => a + b) / 3;

  /// The maximum proportion component of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.max(Color.turquoise));
  ///     // 0.8784313725490196
  ///
  static num max(String color) =>
      rgbProportions(color).reduce((a, b) => a > b ? a : b);

  /// The minimum proportion component of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.min(Color.turquoise));
  ///     // 0.25098039215686274
  ///
  static num min(String color) =>
      rgbProportions(color).reduce((a, b) => a < b ? a : b);

  /// The chroma, or range of proportion components, of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.chroma(Color.turquoise));
  ///     // 0.6274509803921569
  ///
  static num chroma(String color) => max(color) - min(color);

  static num lightness(String color) => (max(color) + min(color)) / 2;

  /// The lightness, or mean of the proportion component optima, of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.lightness(Color.turquoise));
  ///     // 0.5647058823529412
  ///
  static num lightnessInPercent(String color) =>
      (lightness(color) * 100).round();

  /// The luma, or mean proportion component weighted by human perception of lightness, of [color].
  ///
  /// Example:
  ///
  ///     print(ColorProperty.luma(Color.turquoise));
  ///     // 0.683670588235294
  ///
  static num luma(String color) {
    var components = rgbProportions(color);
    return List.generate(3, (i) => components[i] * [0.299, 0.587, 0.114][i])
        .fold(0, (a, b) => a + b);
  }

  static num _h(String color) {
    var c = chroma(color);
    if (c == 0) c == 0.0001;
    var m = max(color);

    if (m == redProportion(color))
      return ((greenProportion(color) - blueProportion(color)) / c) % 6;

    if (m == greenProportion(color))
      return (blueProportion(color) - redProportion(color)) / c + 2;

    return (redProportion(color) - greenProportion(color)) / c + 4;
  }

  /// The hue, or direction, of [color], in degrees.
  ///
  /// Example:
  ///
  ///     print(ColorProperty.hueInDegrees(Color.turquoise));
  ///     // 174.0
  ///
  static num hueInDegrees(String color) => (60 * _h(color) * 100).round() / 100;

  static num hueInRadian(String color) => _h(color) / 3 * pi;

  static num saturation(String color) => lightness(color) == 1
      ? 0
      : chroma(color) / (1 - (2 * lightness(color) - 1).abs());

  /// The hsl saturation of [color].
  static num saturationInPercent(String color) =>
      (saturation(color) * 100).round();
}
