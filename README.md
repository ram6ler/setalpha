# setalpha

A convenience package for setting and accessing web colors, adjusting
the alpha levels of given colors and mixing new colors.

## Demos

* [Color Breakdown](https://color-breakdown.netlify.com/)

 A little app that demonstrates color manipulation, component data,
 finding similar colors and setting alpha levels using setalpha.

* [Falco Shapes](https://falco-shapes.netlify.com/)

A little combinatorics game based on Marsha Falco's game of *Set*;
setalpha was used to color the pieces on the board.

## Usage

Simple usage examples:  

* Conveniently get properties of a color.

```dart
final ps = ColorProperties(Color.cornflowerBlue);
  print("""
         Color: $ps

           Red: ${ps.red}
         Green: ${ps.green}
          Blue: ${ps.blue}
         Alpha: ${ps.alpha}
        Chroma: ${ps.chroma}
           Hue: ${ps.hueInDegrees}
     Intensity: ${ps.intensity}
     Lightness: ${ps.lightness}
    Saturation: ${ps.saturation}
  """);
```

```text
         Color: #6495EDFF

           Red: 100
         Green: 149
          Blue: 237
         Alpha: 1.0
        Chroma: 0.5372549019607844
           Hue: 218.54014598540147
     Intensity: 0.6352941176470589
     Lightness: 0.6607843137254902
    Saturation: 0.7919075144508672
```

* Also works with hex, rgb, rgba, hsl, hsla expressions:

```dart
  // Change the color the ColorProperties instance points to...
  ps.color = "rgba(50,150,200,0.75)";
  print("""
         Color: $ps

           Red: ${ps.red},
         Green: ${ps.green}
          Blue: ${ps.blue}
         Alpha: ${ps.alpha}
        Chroma: ${ps.chroma}
           Hue: ${ps.hueInDegrees}
     Intensity: ${ps.intensity}
     Lightness: ${ps.lightness}
    Saturation: ${ps.saturation}
  """);
```

```text
         Color: #3296C8BF

           Red: 50,
         Green: 150
          Blue: 200
         Alpha: 0.7490196078431373
        Chroma: 0.5882352941176471
           Hue: 199.99999999999997
     Intensity: 0.5228758169934641
     Lightness: 0.49019607843137253
    Saturation: 0.6000000000000001
```

* Get `cornflowerblue` with an alpha value of 0.5.

```dart
print(setAlpha(Color.cornflowerBlue, 0.5));
```

```text
#6495ED80
```

* Also works for other hex and hsl expressions...

```dart
print(setAlpha("#6495ED", 0.5));
print(setAlpha("hsl(218.54deg, 79%, 66%)", 0.5));
```

```text
#6495ED80
#6495ED80
```

* Which web colors are nearest `cornflourblue` in RGB-space?

```dart
for (final neighbor in colorsNearestRGB(Color.cornflowerBlue, 3)) {
    print(neighbor);
}
```

```text
cornflowerblue
mediumslateblue
royalblue
```

* ... and in HSL-space?

```dart
for (final neighbor in colorsNearestHSL(Color.cornflowerBlue, 3)) {
    print(neighbor);
}
```

```text
cornflowerblue
royalblue
skyblue
```

* Let's mix 3 parts `cornflowerblue` with 2 parts `maroon`...

```dart
print(colorMix([Color.cornflowerBlue, Color.maroon], [3, 2]));
```

```text
#6F598EFF
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://bitbucket.org/ram6ler/setalpha/issues
