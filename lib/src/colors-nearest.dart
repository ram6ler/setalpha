part of setalpha;

/// The [n] css colors that are nearest in rgb space to [color].
List<String> colorsNearestRGB(String color, [int n = 3]) {
  final rgb = ColorProperty.rgba(color),
      red = rgb[0],
      green = rgb[1],
      blue = rgb[2],
      colorDistances = [
    ...Color._colorData.keys.map((key) {
      final rgb = ColorProperty.rgba(key),
          r = rgb[0] - red,
          g = rgb[1] - green,
          b = rgb[2] - blue,
          squareDistance = r * r + g * g + b * b;
      return <String, Comparable>{'color': key, 'value': squareDistance};
    })
  ]..sort((a, b) => a['value'].compareTo(b['value']));

  return [...colorDistances.sublist(0, n).map((x) => x['color'].toString())];
}

/// The [n] css colors that are nearest in hsl space to [color].
List<String> colorsNearestHSL(String color, [int n = 3]) {
  final hue = ColorProperty.hueInDegrees(color);
  if (hue == null) throw Exception('Hue not defined for $color.');
  final saturation = ColorProperty.saturation(color),
      lightness = ColorProperty.lightness(color),
      hueDifferences = [
    ...Color._colorData.keys.map((key) {
      final h = ColorProperty.hueInDegrees(key);
      if (h == null) return null;
      final greater = h > hue ? h : hue,
          lesser = h < hue ? h : hue,
          d = greater - lesser;

      final dp = (d > 180 ? 360 - d : d) / 180,
          s = ColorProperty.saturation(key) - saturation,
          l = ColorProperty.lightness(key) - lightness;
      return <String, Comparable>{
        'color': key,
        'distance': dp * dp + s * s + l * l
      };
    }).where((d) => d != null)
  ]..sort((a, b) => a['distance'].compareTo(b['distance']));

  return [...hueDifferences.sublist(0, n).map((d) => d['color'].toString())];
}
