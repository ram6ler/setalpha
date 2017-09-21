// Copyright (c) 2017, Richard Ambler. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:setalpha/setalpha.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    // CSS color "lightblue" with an alpha value of 0.5.
    String desiredResult = "rgba(173,216,230,0.5)";

    setUp(() {});

    test('First Test', () {
      expect(setAlpha("lightblue", 0.5) == desiredResult, isTrue);
    });

    test('Second Test', () {
      expect(setAlpha("#add8e6", 0.5) == desiredResult, isTrue);
    });

    test('First Test', () {
      expect(setAlpha("rgb(173,216,230)", 0.5) == desiredResult, isTrue);
    });

    test('First Test', () {
      expect(setAlpha(Color.lightBlue, 0.5) == desiredResult, isTrue);
    });
  });
}
