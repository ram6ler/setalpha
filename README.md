# setalpha

A convenience package for setting and accessing web colors, adjusting the alpha levels of given colors and mixing new colors.

## Usage

A simple usage example:  

```dart
import 'package:setalpha/setalpha.dart';

void main() {
  // Get cornflowerblue with an alpha value of 0.3...
  print(setAlpha(Color.cornflowerBlue, 0.3));
  // rgba(100,149,237,0.3)

  // Also works for hex and hsl expressions...
  print(setAlpha("#add8e6", 0.5));
  // rgba(173,216,230,0.5)

  print(setAlpha("hsl(195, 53%, 79%)", 0.5));
  // rgba(173,216,230,0.5)

  // Which web color is nearest (30, 60, 120) in RGB-space?
  print(colorNearestRGB(30, 60, 120));
  // midnightblue

  // Let's mix 3 parts cornflowerblue with 2 parts maroon...
  print(colorMix([Color.cornflowerBlue, Color.maroon], [3, 2]));
  // #6f598e
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://bitbucket.org/ram6ler/setalpha/issues
