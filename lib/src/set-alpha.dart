part of setalpha;

/// Returns a CSS color with a set [alpha].
///
/// Takes in a legal css [color] (e.g. "violet", "#abc", "rgb(100,50,20)",
/// "hsl(195, 53%, 79%)") and returns a css rgba color expression.]
///
/// Example:
///
///     String col1 = setAlpha(Color.violet, 0.3),
///       col2 = setAlpha("violet", 0.3),
///       col3 = setAlpha("rbg(238,130,238)", 0.3);
///
String setAlpha(String color, [num alpha]) {
  String rgbHex;
  if (color.contains("rgb")) {
    var componentList = color.replaceAll(RegExp(r"[^0-9,]"), "").split(",");
    if (componentList.length == 4) alpha = num.parse(componentList.last);
    // red-green-blue
    rgbHex = componentList.sublist(0, 3).map((x) {
      String hex = int.parse(x).toRadixString(16);
      if (hex.length == 1)
        return "0$hex";
      else
        return hex;
    }).join();
  } else if (color.contains("hsl")) {
    if (alpha == null) alpha = 1;
    // hue-saturation-lightness
    List<num> split = color
        .replaceAll(RegExp(r"[^0-9,%]"), "")
        .split(",")
        .map((x) => x.contains("%")
            ? num.parse(x.replaceAll(RegExp(r"[^0-9]"), "")) / 100
            : num.parse(x))
        .toList();
    num hue = split[0],
        saturation = split[1],
        lightness = split[2],
        chroma = (1 - (2 * lightness - 1).abs()) * saturation,
        h = hue / 60,
        hfloor = h.floor(),
        x = chroma * (1 - (h % 2 - 1).abs()),
        m = lightness - chroma / 2,
        r1,
        g1,
        b1;
    switch (hfloor) {
      case 0:
        r1 = chroma;
        g1 = x;
        b1 = 0;
        break;
      case 1:
        r1 = x;
        g1 = chroma;
        b1 = 0;
        break;
      case 2:
        r1 = 0;
        g1 = chroma;
        b1 = x;
        break;
      case 3:
        r1 = 0;
        g1 = x;
        b1 = chroma;
        break;
      case 4:
        r1 = x;
        g1 = 0;
        b1 = chroma;
        break;
      case 5:
        r1 = chroma;
        g1 = 0;
        b1 = x;
        break;
      default:
        r1 = 0;
        g1 = 0;
        b1 = 0;
        break;
    }
    String toHex(num x) =>
        ((x + m) * 255).round().toRadixString(16).padLeft(2, "0");
    rgbHex = [r1, g1, b1].map(toHex).join("");
  } else if (color[0] == "#") {
    // hex
    rgbHex = color.replaceAll(RegExp(r"[^A-Fa-f0-9]"), "");

    if (rgbHex.length == 4) {
      if (alpha == null) alpha = int.parse(rgbHex[3], radix: 16) / 15;
      rgbHex = rgbHex.substring(0, 3);
    }

    if (rgbHex.length == 8) {
      if (alpha == null)
        alpha = int.parse(rgbHex.substring(6), radix: 16) / 255;
      rgbHex = rgbHex.substring(0, 6);
    }
  } else {
    if (alpha == null) alpha = 1;
    // assumed color name
    rgbHex = Color._colorData[color];
  }

  String sixDigitRgbHex = rgbHex.length == 3
      ? rgbHex.split("").map((x) => "$x$x").join()
      : rgbHex.substring(0, 6);

  var rgb = List<int>.generate(
      3,
      (i) =>
          int.parse(sixDigitRgbHex.substring(i * 2, (i + 1) * 2), radix: 16));

  String helper(int x) => x.toRadixString(16).padLeft(2, "0");

  return "#${rgb.map(helper).join("")}${helper((alpha * 255).round())}";
}
