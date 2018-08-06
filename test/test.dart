import "package:setalpha/setalpha.dart";

void simpleDivs(Iterable<String> colors) {
  for (var color in colors) {
    print("<div>($color)</div>");
    var luma = ColorProperty.luma(color);
    var h = ColorProperty.hueInDegrees(color),
        s = ColorProperty.saturationAsPercent(color),
        l = ColorProperty.lightnessAsPercent(color),
        rgb = ColorProperty.rgba(color),
        r = rgb[0],
        g = rgb[1],
        b = rgb[2],
        hex = setAlpha(color);

    print(
        "<div style='margin: 5pt; padding: 5pt; border-radius: 5pt; height: 100px; background: $color; color: ${luma > 0.5 ? "black" : "white"};'>$color<br>rgb($r,$g,$b)<br>${h == null ? "null" : "hsl(${h}deg, $s%, $l%)"}<br>${hex.substring(0, 7)}</div>");
  }
}

void main() {
  print(setAlpha("hsla(120deg,50%,50%,0.5)"));
  for (var f in [/*testAll,*/ testHues, testNearest, testMix, testAlpha]) f();
}

void testAll() {
  print("<h1>All colors</h1>");
  simpleDivs(Color.colors);
}

void testHues() {
  print("<h1>Similar hues</h1>");
  print("<h2>maroon</h2>");
  simpleDivs(colorsNearestHSL(Color.maroon));
  print("<h2>turquoise</h2>");
  simpleDivs(colorsNearestHSL(Color.turquoise));
  print("<h2>thistle</h2>");
  simpleDivs(colorsNearestHSL(Color.thistle));
  print("<h2>violet</h2>");
  simpleDivs(colorsNearestHSL(Color.violet));
}

void testMix() {
  print("<h1>Mixing</h1>");
  print("<h2>steelblue to tomato</h2>");
  var color1 = Color.steelBlue, color2 = Color.tomato;
  var weights = List.generate(11, (i) => i * 0.1);
  simpleDivs(weights.map((w) => colorMix([color1, color2], [1 - w, w])));
}

void testAlpha() {
  print("<h1>Alpha levels</h1>");
  print("<h1>spring green</h1>");
  var color = Color.springGreen;
  var alphas = List.generate(11, (i) => i * 0.1);
  simpleDivs(alphas.map((a) => setAlpha(color, a)));
}

void testNearest() {
  print("<h1>Nearest colors</h1>");
  print("<h2>maroon</h2>");
  simpleDivs(colorsNearestRGB(Color.maroon));
  print("<h2>turquoise</h2>");
  simpleDivs(colorsNearestRGB(Color.turquoise));
  print("<h2>thistle</h2>");
  simpleDivs(colorsNearestRGB(Color.thistle));
  print("<h2>violet</h2>");
  simpleDivs(colorsNearestRGB(Color.violet));
}
