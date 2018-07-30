part of setalpha;

/// Returns the name of the css color nearest the input rgb values.
///
/// Returns the css color that is nearest in rgb space,
/// using Euclidean distance as a measure, to the point
/// with the rgb coordinates ([red], [green], [blue]).
///
/// Example:
///
///     print(colorNearestRGB(145, 138, 236));
///     // cornflowerblue
///
String colorNearestRGB(num red, num green, num blue) {
  num minIndex = 0, minSquareDistance = double.infinity;
  for (int i = 0; i < Color._colorData.length; i++) {
    String hex = Color._colorData.values.elementAt(i);
    num r = int.parse(hex.substring(0, 2), radix: 16),
        g = int.parse(hex.substring(2, 4), radix: 16),
        b = int.parse(hex.substring(4, 6), radix: 16);
    num squareDistance =
        (red - r) * (red - r) + (green - g) * (green - g) + (blue - b) * (blue - b);
    if (minSquareDistance > squareDistance) {
      minSquareDistance = squareDistance;
      minIndex = i;
    }
  }
  return Color._colorData.keys.elementAt(minIndex);
}
