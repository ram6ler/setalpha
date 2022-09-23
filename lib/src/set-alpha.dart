part of setalpha;

extension SetAlpha on String {
  String toHexWithAlpha(num alpha) => setAlpha(this, alpha);
}

/// Returns a color with a set [alpha].
///
/// Takes in a legal css [color] (e.g. "violet", "#abc",
/// "rgb(100,50,20)", "hsl(195, 53%, 79%)") and an alpha
/// value and returns an 8 digit hex color representation.
///
/// If [alpha] is set, it overrides any alpha level that may
/// be contained in [color].
///
String setAlpha(String color, [num? alpha]) {
  color = color.trim().toUpperCase();
  String d8Hex;
  if (color[0] == "#") {
    switch (color.length) {
      case 4:
        d8Hex = _d3HexToD8Hex(color);
        break;
      case 5:
        d8Hex = _d4HexToD8Hex(color);
        break;
      case 7:
        d8Hex = _d6HexToD8Hex(color);
        break;
      case 9:
        d8Hex = color;
        break;
      default:
        throw Exception("Unrecognized color: $color");
    }
  } else if (color.contains("RGBA")) {
    d8Hex = _rgbaToD8Hex(color);
  } else if (color.contains("RGB")) {
    d8Hex = _rgbToD8Hex(color);
  } else if (color.contains("HSLA")) {
    d8Hex = _hslaToD8Hex(color);
  } else if (color.contains("HSL")) {
    d8Hex = _hslToD8Hex(color);
  } else {
    color = color.toLowerCase();
    if (!Color._colorData.containsKey(color)) {
      throw Exception("Unrecognized color: '$color'.");
    }

    d8Hex = _d6HexToD8Hex("#${Color._colorData[color]}");
  }

  return alpha == null
      ? d8Hex
      : "${d8Hex.substring(0, 7)}${(alpha * 255).round().toRadixString(16).padLeft(2, "0")}"
          .toUpperCase();
}
