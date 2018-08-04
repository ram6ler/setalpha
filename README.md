# setalpha

A convenience package for setting and accessing web colors, adjusting the alpha levels of given colors and mixing new colors.

## Usage

A simple usage example:  

```dart
import 'package:setalpha/setalpha.dart';

void main() {
  // Get cornflowerblue with an alpha value of 0.3...
  print(setAlpha(Color.cornflowerBlue, 0.3));
  // #6495ED4D

  // Also works for other hex and hsl expressions...
  print(setAlpha("#6495ED", 0.5));
  // #6495ED80

  print(setAlpha("hsl(218.54deg, 79%, 66%)", 0.5));
  // #6495ED80

  // Which web color is nearest cornflourblue in RGB-space?
  print(colorsNearest(Color.cornflowerBlue, 2).last);
  // mediumslateblue

  // Let's mix 3 parts cornflowerblue with 2 parts maroon...
  print(colorMix([Color.cornflowerBlue, Color.maroon], [3, 2]));
  // #6F598EFF
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://bitbucket.org/ram6ler/setalpha/issues
