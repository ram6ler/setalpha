# Changelog

## 0.9.3

- Small additions and amendments to the `ColorProperties` class.

- Fixed a bug in the interpretation of hsla expressions.

- The `colorsNearest` function has been split into `colorsNearestRGB` and `colorsNearestHSL` that respectively return the nearest colors in RGB-space and HSL-space.

- Added a convenience class `Crayon` that provides access to the *crayon* colors in the html color picker.

## 0.9.2

Dart pub issues (?)

## 0.9.1

- Fixed several bugs that were introduced in the previous version.
- Changed `colorNearestRGB` to a more generic and useful `colorsNearest`, which returns a list of colors in order of increasing distance. (Breaking change.)
- Cleaned up the code: a lot more readable now.

## 0.9.0

- Marked as ready for Dart 2.
- Removed methods from abstract class `Color`: free-standing functions `setAlpha`, `colorMix` and `colorNearestRGB` are more convenient. (This is a breaking change.)
- Output of `setAlpha` now an 8 digit hex value, matching the output of `colorMix`.
- Added an abstract `ColorProperty` class that provides access to various qualities of an input color such as *hue*, *saturation* and *lightness*.

## 0.8.0

Added the function `Color.mix`, which allows us to mix a list of colors.

## 0.7.0

Added the function `Color.nearest`, which returns the css color nearest in rgb space to input rgb values.

## 0.6.0

Now also supports hsl expressions as input to function `setAlpha`.

## 0.5.0

- Set the alpha level of CSS colors.
- Supports color name, hex values, rgb (and rgba) expressions as input to the function `setAlpha`.


