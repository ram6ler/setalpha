part of setalpha;

/// Returns the name of the css color nearest the input rgb values.
///
/// Returns the [n] css colors that are nearest in rgb space to [color],
/// using Euclidean distance as a measure.
///
/// Example:
///
///     print(colorNearest("rgb(145, 138, 236)"));
///     // mediumpurple
///
List<String> colorsNearest(String color, [int n = 3]) {
  var asHex = setAlpha(color),
      rgb = List.generate(
          3,
          (i) => int.parse(asHex.substring(i * 2 + 1, (i + 1) * 2 + 1),
              radix: 16)),
      red = rgb[0],
      green = rgb[1],
      blue = rgb[2];

  var colorDistances = Color._colorData.keys.map((key) {
    var hex = Color._colorData[key],
        r = int.parse(hex.substring(0, 2), radix: 16),
        g = int.parse(hex.substring(2, 4), radix: 16),
        b = int.parse(hex.substring(4, 6), radix: 16),
        squareDistance = (red - r) * (red - r) +
            (green - g) * (green - g) +
            (blue - b) * (blue - b);
    return <String, Comparable>{"color": key, "value": squareDistance};
  }).toList()
    ..sort((a, b) => a["value"].compareTo(b["value"]));

  return colorDistances
      .sublist(0, n)
      .map((x) => x["color"].toString())
      .toList();
}
