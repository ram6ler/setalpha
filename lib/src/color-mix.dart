part of setalpha;

/// Returns the color that represents the weighted mean of a list of colors.
///
/// Example:
///
///     // Two parts blue to one part red:
///     String mix = colorMix([Color.blue, Color.red], [2, 1]);
///
String colorMix(List<String> colors, List<num> weights,
    {bool nearestCssColor = false}) {
  if (weights.length != colors.length) {
    throw Exception('A weight should be provided for each color.');
  }

  num weightSum = weights.fold(0, (a, b) => a + b);

  List<List<num>> components = [
    ...colors
        .map(setAlpha)
        .map((color) => List.generate(
            4, (i) => color.substring(i * 2 + 1, (i + 1) * 2 + 1)))
        .map((components) =>
            [...components.map((component) => int.parse(component, radix: 16))])
  ];

  num weightedMean(int index) => (List<num>.generate(
                  components.length, (i) => components[i][index] * weights[i])
              .fold(0, (a, b) => a + b) /
          weightSum)
      .round();

  num red = weightedMean(0),
      green = weightedMean(1),
      blue = weightedMean(2),
      alpha = weightedMean(3);

  return nearestCssColor
      ? colorsNearestRGB('rgb($red, $green, $blue)').first
      : '#${[
          red,
          green,
          blue,
          alpha
        ].map((x) => x.toInt().toRadixString(16).padLeft(2, '0')).join('')}'
          .toUpperCase();
}
