import 'package:setalpha/setalpha.dart';

void main() {
  // Get cornflowerblue with an alpha value of 0.3...
  print(setAlpha(Color.cornflowerBlue, 0.3));
  // #6495ed4d

  // Also works for other hex and hsl expressions...
  print(setAlpha("#add8e6", 0.5));
  // #add8e680

  print(setAlpha("hsl(195, 53%, 79%)", 0.5));
  // #add8e680

  // Which web color is nearest 30, 60, 120 in RGB-space?
  print(colorNearestRGB(30, 60, 120));
  // midnightblue

  // Let's mix 3 parts cornflowerblue with 2 parts maroon...
  print(colorMix([Color.cornflowerBlue, Color.maroon], [3, 2]));
  // #6f598eff
}
