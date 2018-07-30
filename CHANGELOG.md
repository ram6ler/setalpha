# Changelog

## 0.9.0

- Marked as ready for Dart 2.
- Removed methods from abstract class `Color`: free-standing functions are more convenient. (This is a breaking change.)

## 0.8.0

Added the function `Color.mix`, which allows us to mix a list of colors.

## 0.7.0

Added the function `Color.nearest`, which returns the css color nearest in rgb space to input rgb values.



## 0.6.0

Now also supports hsl expressions as input to function `setAlpha`.



## 0.5.0

- Set the alpha level of CSS colors.
- Supports color name, hex values, rgb (and rgba) expressions as input to the function `setAlpha`.


