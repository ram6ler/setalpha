part of setalpha;

abstract class ColorProperty {
  /// The reg-green-blue proportion components of [color].
  static List<num> rgb(String color) {
    var hex = setAlpha(color).substring(1, 7);
    return List.generate(3, (i) => int.parse(hex.substring(i * 2, (i + 1) * 2), radix: 16) / 255);
  }

  /// The red proportion component of [color].
  static num red(String color) => rgb(color)[0];

  /// The green proportion component of [color].
  static num green(String color) => rgb(color)[1];

  /// The blue proportion component of [color].
  static num blue(String color) => rgb(color)[2];

  /// The intensity, or mean proportion component, of [color].
  static num intensity(String color) => rgb(color).fold(0, (a, b) => a + b) / 3;

  /// The maximum proportion component of [color].
  static num max(String color) => rgb(color).reduce((a, b) => a > b ? a : b);

  /// The minimum proportion component of [color].
  static num min(String color) => rgb(color).reduce((a, b) => a < b ? a : b);

  /// The chroma, or range of proportion components, of [color].
  static num chroma(String color) => max(color) - min(color);

  /// The lightness, or mean of the proportion component optima, of [color].
  static num lightness(String color) => (max(color) + min(color)) / 2;

  /// The luma, or mean proportion component weighted by human perception of lightness, of [color].
  static num luma(String color) {
    var components = rgb(color);
    return List.generate(3, (i) => components[i] * [0.299, 0.587, 0.114][i])
        .fold(0, (a, b) => a + b);
  }

  static num _h(String color) {
    var c = chroma(color);
    if (c == 0) return null;
    var m = max(color);

    if (m == red(color)) return (green(color) - blue(color)) / c % 6;

    if (m == green(color)) return (blue(color) - red(color)) / c + 2;

    return (red(color) - green(color)) / c + 4;
  }

  /// The hue, or direction, of [color], in degrees.
  static num hueInDegrees(String color) => 60 * _h(color);

  /// The hue, or direction, of [color], as a proportion.
  static num hueInRevolutions(String color) => _h(color) * 6;

  /// The hsl saturation of [color].
  static num saturation(String color) =>
      lightness(color) == 1 ? 0 : chroma(color) / (1 - (2 * lightness(color) - 1).abs());
}
