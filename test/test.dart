import 'package:setalpha/setalpha.dart';

void simpleDivs(Iterable<String> colors) {
  print('<div class="container">');
  for (final color in colors) {
    print('<div class="group"><div class="color">($color)</div>');
    final ps = ColorProperties(color),
        luma = ps.luma,
        h = ps.hueInDegrees,
        s = ps.saturationAsPercent,
        l = ps.lightnessAsPercent,
        r = ps.red,
        g = ps.green,
        b = ps.blue,
        hex = setAlpha(color);

    print('''
  <div class="sample" style="background: $color; color: ${luma > 0.6 ? 'black' : 'white'};">
    $color<br>
    rgb($r,$g,$b)<br>
    ${h == null ? 'null' : 'hsl(${h}deg, $s%, $l%)'}<br>
    ${hex.substring(0, 7)}
  </div>
</div>
''');
  }
  print('</div>');
}

void main() {
  print(style);
  for (var f in [
    testAll,
    testHues,
    testNearest,
    testMix,
    testAlpha,
  ]) f();
}

final style = '''
<style>
  body {
      font-family: monospace;
      font-size: 9pt;
  }
  .container {
      display: grid;
      gap: 10pt;
      grid-template-columns: auto auto auto;
  }
  .color {
    font-size: 12pt;
    padding-bottom: 3pt;
    border-bottom: 1pt solid;
    margin-bottom: 3pt;
  }
  .sample {
      height: 80pt;
      padding: 5pt;
      border-radius: 5pt;
  }
</style>

''';

void testAll() {
  print('<h1>All colors</h1>');
  simpleDivs(Color.colors);
}

void testHues() {
  print('<h1>Similar hues</h1>');
  print('<h2>maroon</h2>');
  simpleDivs(colorsNearestHSL(Color.maroon));
  print('<h2>turquoise</h2>');
  simpleDivs(colorsNearestHSL(Color.turquoise));
  print('<h2>thistle</h2>');
  simpleDivs(colorsNearestHSL(Color.thistle));
  print('<h2>violet</h2>');
  simpleDivs(colorsNearestHSL(Color.violet));
}

void testMix() {
  print('<h1>Mixing</h1>');
  print('<h2>steelblue to tomato - 12 steps</h2>');
  final color1 = Color.steelBlue,
      color2 = Color.tomato,
      steps = 12,
      weights = List.generate(steps, (i) => i / steps);
  simpleDivs(weights.map((w) => colorMix([color1, color2], [1 - w, w])));
}

void testAlpha() {
  print('<h1>Alpha levels</h1>');
  print('<h2>spring green - 12 steps</h2>');
  final color = Color.springGreen,
      steps = 12,
      alphas = List.generate(steps, (i) => i / steps);
  simpleDivs(alphas.map((a) => setAlpha(color, a)));
}

void testNearest() {
  print('<h1>Nearest colors</h1>');
  print('<h2>maroon</h2>');
  simpleDivs(colorsNearestRGB(Color.maroon));
  print('<h2>turquoise</h2>');
  simpleDivs(colorsNearestRGB(Color.turquoise));
  print('<h2>thistle</h2>');
  simpleDivs(colorsNearestRGB(Color.thistle));
  print('<h2>violet</h2>');
  simpleDivs(colorsNearestRGB(Color.violet));
}
