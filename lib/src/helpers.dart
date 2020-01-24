part of setalpha;

final _rxRgb = RegExp(r'[^0-9,.]'), _rxHex = RegExp(r'[^#0-9a-fA-F]');

void _except(String color) => throw Exception('Unrecognized color: "$color".');

String _byteToHexString(num x) => x.round().toRadixString(16).padLeft(2, '0');

String _rgbToD8Hex(String color) {
  final split = [...color.replaceAll(_rxRgb, '').split(',').map(num.parse)];
  if (split.length != 3 || split.any((x) => x < 0 || x > 255.5)) {
    _except(color);
  }

  return '#${split.map(_byteToHexString).join()}FF'.toUpperCase();
}

String _rgbaToD8Hex(String color) {
  final split = [...color.replaceAll(_rxRgb, '').split(',').map(num.parse)];
  if (split.length != 4 ||
      split.sublist(0, 3).any((x) => x < 0 || x > 255.5) ||
      split.last < 0 ||
      split.last > 1) {
    _except(color);
  }
  return '#${split.sublist(0, 3).map(_byteToHexString).join()}${_byteToHexString(split.last * 255)}'
      .toUpperCase();
}

String _d3HexToD8Hex(String color) {
  color = color.replaceAll(_rxHex, '');
  if (color.length != 4) ;

  return '#${List.generate(3, (i) => '${color[i + 1] * 2}').join()}FF'
      .toUpperCase();
}

String _d4HexToD8Hex(String color) {
  color = color.replaceAll(_rxHex, '');
  if (color.length != 5) {
    _except(color);
  }

  return '#${List.generate(4, (i) => '${color[i + 1] * 2}').join()}'
      .toUpperCase();
}

String _d6HexToD8Hex(String color) {
  color = color.replaceAll(_rxHex, '');
  if (color.length != 7) {
    _except(color);
  }

  return '#${List.generate(3, (i) => '${color.substring(i * 2 + 1, i * 2 + 3)}').join()}FF'
      .toUpperCase();
}

String _hslaToD8Hex(String color) {
  final values = [...color.replaceAll(_rxRgb, '').split(',').map(num.parse)];

  if (values.length != 4) {
    _except(color);
  }

  final opaque = _hslToD8Hex('hsl(${values.sublist(0, 3).join(',')})');
  return '${opaque.substring(0, 7)}${_byteToHexString(values.last * 255)}';
}

String _hslToD8Hex(String color) {
  final values = [...color.replaceAll(_rxRgb, '').split(',').map(num.parse)];

  if (values.length != 3) {
    _except(color);
  }

  final h = values[0], s = values[1] / 100, l = values[2] / 100;

  if (h < 0 || h >= 360) {
    _except(color);
  }

  if (s < 0 || s > 100) {
    _except(color);
  }

  if (l < 0 || l > 100) {
    _except(color);
  }

  final c = (1 - (2 * l - 1).abs()) * s,
      hPrime = h / 60,
      x = c * (1 - (hPrime % 2 - 1).abs());

  num r, g, b;
  if (hPrime <= 1) {
    r = c;
    g = x;
    b = 0;
  } else if (hPrime <= 2) {
    r = x;
    g = c;
    b = 0;
  } else if (hPrime <= 3) {
    r = 0;
    g = c;
    b = x;
  } else if (hPrime <= 4) {
    r = 0;
    g = x;
    b = c;
  } else if (hPrime <= 5) {
    r = x;
    g = 0;
    b = c;
  } else {
    r = c;
    g = 0;
    b = x;
  }

  final m = l - c / 2,
      result = '#${[
    r,
    g,
    b
  ].map((value) => _byteToHexString((value + m) * 255)).join()}FF';

  return result.toUpperCase();
}
