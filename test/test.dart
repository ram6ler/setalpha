import 'package:setalpha/setalpha.dart';

void main() {
  // CSS color "lightblue" with an alpha value of 0.5.
  String desiredResult = "rgba(173,216,230,0.5)";

  // Use a CSS color name...
  print(setAlpha("lightblue", 0.5) == desiredResult);

  // Or a CSS hex value...
  print(setAlpha("#add8e6", 0.5) == desiredResult);

  // Or a CSS hsl value...
  print(setAlpha("hsl(195, 53%, 79%)", 0.5) == desiredResult);

  // Or a CSS rgb expression...
  print(setAlpha("rgb(173,216,230)", 0.5) == desiredResult);

  // Or using the convenience class Color...
  print(setAlpha(Color.lightBlue, 0.5) == desiredResult);
}
