part of setalpha;

/// Returns a CSS color with a set [alpha].
///
/// Takes in a legal css [color] ("violet", "#abc", "rgb(100,50,20)", etc.)
/// and a desired [alpha] level, and returns
///
/// Example:
///
///     String col1 = Color.setAlpha(Color.violet, 0.3),
///       col2 = Color.setAlpha("violet", 0.3),
///       col3 = Color.setAlpha("rbg(238,130,238)", 0.3);
///     // col1, col2 and col3 are all "rgba(238,130,238,0.3)".
///
String setAlpha(String color, [num alpha = 1]) {
  String rgbHex;
  if (color.contains("rgb")) {
    rgbHex = color
        .replaceAll(new RegExp(r"[^0-9,]"), "")
        .split(",")
        .sublist(0, 3)
        .map((x) {
      String hex = int.parse(x).toRadixString(16);
      if (hex.length == 1)
        return "0$hex";
      else
        return hex;
    }).join();
  } else if (color[0] == "#") {
    rgbHex = color.replaceAll(new RegExp(r"[^A-Fa-f0-9]"), "");
  } else {
    rgbHex = Color._colorData[color];
  }
  String sixDigitRgbHex = rgbHex.length == 3
      ? rgbHex.split("").map((x) => "$x$x").join()
      : rgbHex.substring(0, 6);

  var rgb = new List<int>.generate(
      3,
      (i) =>
          int.parse(sixDigitRgbHex.substring(i * 2, (i + 1) * 2), radix: 16));
  return "rgba(${rgb.join(",")},$alpha)";
}
