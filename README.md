# setalpha

A library for conveniently setting the alpha level of a CSS color.

## Usage

A simple usage example:  

```dart
import 'package:setalpha/setalpha.dart';

void main() {
  // CSS color "lightblue" with an alpha value of 0.5.
  String desiredResult = "rgba(173,216,230,0.5)";

  // Use a CSS color name...
  assert(setAlpha("lightblue", 0.5) == desiredResult);
  
  // Or a CSS hex value...
  assert(setAlpha("#add8e6", 0.5) == desiredResult);

  // Or a CSS hsl value...
  assert(setAlpha("hsl(195, 53%, 79%)", 0.5) == desiredResult);
  
  // Or a CSS rgb expression...
  assert(setAlpha("rgb(173,216,230)", 0.5) == desiredResult);
  
  // Or using the convenience class Color...
  assert(setAlpha(Color.lightBlue, 0.5) == desiredResult);

  // What is the css color nearest in rgb space to the
  // rgb coordinates (145, 138, 236)?
  assert(Color.nearest(145, 138, 236) == "cornflowerblue");
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://bitbucket.org/ram6ler/setalpha/issues
