import "color.dart" show Color;
import "color_properties.dart" show ColorProperties;

int _byDistance((String, num) a, (String, num) b) {
  final (_, d1) = a;
  final (_, d2) = b;
  return d1.compareTo(d2);
}

String _getColor((String, num) a) {
  final (color, _) = a;
  return color;
}

/// The `n` css colors that are nearest in rgb space to `color`.
///
/// Example:
/// ```dart
/// final color = "rgb(10, 20, 30)";
/// for (final c in colorsNearestRGB(color, 3)) {
///   print(c);
/// }
/// ```
/// Output:
/// ```text
/// black
/// midnightblue
/// darkslategray
/// ```
List<String> colorsNearestRGB(String color, [int n = 3]) {
  final ps = ColorProperties(color),
      red = ps.red,
      green = ps.green,
      blue = ps.blue,
      distanceTuple = (String color) {
        final ps = ColorProperties(color),
            r = ps.red - red,
            g = ps.green - green,
            b = ps.blue - blue,
            squareDistance = r * r + g * g + b * b;
        return (color, squareDistance);
      },
      colorDistances = [...Color.colorData.keys.map(distanceTuple)]
        ..sort(_byDistance);

  return [...colorDistances.sublist(0, n).map(_getColor)];
}

/// The `n` css colors that are nearest in hsl space to `color`.
///
/// Example:
/// ```dart
/// final color = "rgb(10, 20, 30)";
/// for (final c in colorsNearestHSL(color, 3)) {
///   print(c);
/// }
/// ```
/// Output:
/// ```text
/// midnightblue
/// darkslategray
/// darkslateblue
/// ```
List<String> colorsNearestHSL(String color, [int n = 3]) {
  final ps = ColorProperties(color), hue = ps.hueInDegrees;
  if (hue == null) throw Exception("Hue not defined for $color.");
  final saturation = ps.saturation,
      lightness = ps.lightness,
      distanceTuple = (String color) {
        final ps = ColorProperties(color), h = ps.hueInDegrees;
        if (h == null) return null;

        final greater = h > hue ? h : hue,
            lesser = h < hue ? h : hue,
            d = greater - lesser;

        final dp = (d > 180 ? 360 - d : d) / 180,
            s = ps.saturation - saturation,
            l = ps.lightness - lightness;
        return (color, dp * dp + s * s + l * l);
      },
      hueDifferences = [
        ...Color.colorData.keys.map(distanceTuple).where((d) => d != null)
      ]..sort((a, b) => _byDistance(a!, b!));

  return [...hueDifferences.sublist(0, n).map((t) => _getColor(t!))];
}
