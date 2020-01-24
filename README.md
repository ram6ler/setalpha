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
