import 'package:setalpha/setalpha.dart';

main() {
  final steps = 10,
      from = Color.slateBlue,
      to = Color.lightGoldenrodYellow,
      textColor = (String color) {
        final ps = ColorProperties(color), luma = ps.luma;
        return (ps.luma < 0.7) ? "white" : "black";
      },
      colorMerge = [
        for (var i = 0; i <= steps; i++) colorMix([from, to], [steps - i, i])
      ];

  print(
      "<div style='background: $from; color: ${textColor(from)}'>$from</div>");
  for (final color in colorMerge) {
    print(
        """<div style="background: $color; color: ${textColor(color)}">Mixing...</div>""");
  }
  print("<div style='background: $to; color: ${textColor(to)}'>$to</div>");
}
