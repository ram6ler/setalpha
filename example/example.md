# Example

```dart
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

```

Output:

```html
<div style='background: slateblue; color: white'>slateblue</div>
<div style="background: #6A5ACDFF; color: white">Mixing...</div>
<div style="background: #786ACEFF; color: white">Mixing...</div>
<div style="background: #877ACEFF; color: white">Mixing...</div>
<div style="background: #958ACFFF; color: white">Mixing...</div>
<div style="background: #A49ACFFF; color: white">Mixing...</div>
<div style="background: #B2AAD0FF; color: white">Mixing...</div>
<div style="background: #C0BAD0FF; color: black">Mixing...</div>
<div style="background: #CFCAD1FF; color: black">Mixing...</div>
<div style="background: #DDDAD1FF; color: black">Mixing...</div>
<div style="background: #ECEAD2FF; color: black">Mixing...</div>
<div style="background: #FAFAD2FF; color: black">Mixing...</div>
<div style='background: lightgoldenrodyellow; color: black'>lightgoldenrodyellow</div>
```
