import "package:setalpha/setalpha.dart";

void simpleDivs(List<String> colors) {
  for (var color in colors) {
    var luma = ColorProperty.luma(color);
    var h = ColorProperty.hueInDegrees(color),
        s = ColorProperty.saturationInPercent(color),
        l = ColorProperty.lightnessInPercent(color),
        rgb = ColorProperty.rgb(color),
        r = rgb[0],
        g = rgb[1],
        b = rgb[2],
        hex = setAlpha(color);

    print(
        "<div style='margin: 5pt; padding: 5pt; border-radius: 5pt; width: 400px; height: 200px; background: $color; color: ${luma > 0.5 ? "black" : "white"};'>$color<br>rgb: ($r,$g,$b)<br>hsl: (${h}deg, $s%, $l%)<br>$hex</div>");
  }
}

void main() {
  //simpleDivs(colorsNearest(Color.cornflowerBlue, 5));
  simpleDivs(colorsNearest("hsl(219deg, 79%, 66%)"));

  print("<div>");
  // Get cornflowerblue with an alpha value of 0.3...
  print(setAlpha(Color.cornflowerBlue, 0.3));
  // #6495ed4d

  // Also works for hex and hsl expressions...
  print(setAlpha("#6495ed", 0.5));
  // #6495ed80

  print(setAlpha("hsl(219deg, 79%, 66%)", 0.5));
  // #add8e680

  // Which web color is nearest (30, 60, 120) in RGB-space?
  print(colorsNearest("rgb(30, 60, 120)").first);
  // midnightblue

  // Let's mix 3 parts cornflowerblue with 2 parts maroon...
  print(colorMix([Color.cornflowerBlue, Color.maroon], [3, 2]));
  // #6f598e
  print("</div>");
}
