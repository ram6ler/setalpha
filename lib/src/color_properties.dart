import "set_alpha.dart" show setAlpha;

/// A convenience class for determining properties of colors.
class ColorProperties {
  ColorProperties(this.color);

  /// Style expression representing a color.
  String color;

  /// The red-green-blue proportion components of `color`.
  List<double> get rgbProportions =>
      [...rgba.sublist(0, 3).map((c) => c / 255.0)];

  List<num> get rgba {
    final hex = setAlpha(color).substring(1);
    return List.generate(
        4, (i) => int.parse(hex.substring(i * 2, (i + 1) * 2), radix: 16));
  }

  num _p(num p) => (p * 10000).round() / 100;

  /// The red component of `color`.
  num get red => rgba[0];

  /// The red proportion component of `color`.
  num get redAsProportion => rgbProportions[0];

  /// The red proportion component of `color`, expressed
  /// as a percentage.
  num get redAsPercent => _p(redAsProportion);

  /// The green component of `color`.
  num get green => rgba[1];

  /// The green proportion component of `color`.
  num get greenAsProportion => rgbProportions[1];

  /// The green proportion component of `color`, expressed
  /// as a percentage.
  num get greenAsPercent => _p(greenAsProportion);

  /// The blue component of `color`.
  num get blue => rgba[2];

  /// The blue proportion component of `color`.
  num get blueAsProportion => rgbProportions[2];

  /// The blue proportion component of `color`, expressed
  /// as a percentage.
  num get blueAsPercent => _p(blueAsProportion);

  /// The alpha level of `color`.
  num get alpha => rgba[3] / 255;

  /// The intensity, or mean proportion component, of `color`.
  num get intensity => rgbProportions.fold(0.0, (a, b) => a + b) / 3;

  /// The intensity, or mean proportion component, of `color`,
  /// expressed as a percentage.
  num get intensityAsPercent => _p(intensity);

  /// The maximum proportion component of `color`.
  num get max => rgbProportions.reduce((a, b) => a > b ? a : b);

  /// The maximum proportion component of `color`, expressed
  /// as a percentage.
  num get maxAsPercent => _p(max);

  /// The minimum proportion component of `color`.
  num get min => rgbProportions.reduce((a, b) => a < b ? a : b);

  /// The minimum proportion component of `color`, expressed
  /// as a percentage.
  num get minAsPercent => _p(min);

  /// The chroma, or range of proportion components, of `color`.
  num get chroma => max - min;

  /// The chroma, or range of proportion components, of `color`.
  num get chromaAsPercent => _p(chroma);

  /// The lightness, or mean of the proportion component optima,
  /// of `color`.
  num get lightness => (max + min) / 2;

  /// The lightness, or mean of the proportion component optima,
  /// of `color`, expresses as a percent.
  num get lightnessAsPercent => _p(lightness);

  /// The luma, or mean proportion component weighted by
  /// human perception of lightness, of `color`.
  num get luma {
    final components = rgbProportions;
    return List.generate(3, (i) => components[i] * [0.299, 0.587, 0.114][i])
        .fold(0, (a, b) => a + b);
  }

  /// The luma, or mean proportion component weighted by
  /// human perception of lightness, of `color`, expressed
  /// as a percentage.
  num get lumaAsPercent => _p(luma);

  num? _h() {
    final c = chroma;
    if (c == 0) return null;
    final m = max;

    if (m == redAsProportion) {
      return ((greenAsProportion - blueAsProportion) / c) % 6;
    }

    if (m == greenAsProportion) {
      return (blueAsProportion - redAsProportion) / c + 2;
    }

    return (redAsProportion - greenAsProportion) / c + 4;
  }

  /// The hsl hue, or direction, of `color`, in degrees.
  num? get hueInDegrees {
    final h = _h();
    if (h == null) return null;
    return 60 * h;
  }

  /// The hsl saturation of `color`.
  num get saturation {
    final l = lightness;
    if (l == 0 || l == 1) return 0;
    return chroma / (1 - (2 * l - 1).abs());
  }

  /// The hsl saturation of `color`, expressed as a percentage.
  num get saturationAsPercent => _p(saturation);

  @override
  String toString() => setAlpha(color);
}
