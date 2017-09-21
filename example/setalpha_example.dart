// Copyright (c) 2017, Richard Ambler. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:math';
import '../lib/setalpha.dart';

main() {
  var rand = new Random();
  final num width = 500, height = 500;
  var canvas = new CanvasElement(width: width, height: height);
  bool moreBubbles = true;
  void addBubbles(_) {
    String stroke = Color.allColors[rand.nextInt(Color.allColors.length)],
        fill = setAlpha(stroke, 0.3);
    num x = rand.nextInt(width),
        y = rand.nextInt(height),
        radius = rand.nextInt(width ~/ 10) + 10;
    canvas.context2D
      ..strokeStyle = stroke
      ..save()
      ..translate(x, y)
      ..beginPath()
      ..arc(0, 0, radius, 0, 2 * PI)
      //..fillStyle = "white"
      //..fill()
      ..fillStyle = fill
      ..fill()
      ..stroke()
      ..rotate(rand.nextDouble() * 2 * PI)
      ..fillStyle = stroke
      ..font = "10pt Arial"
      ..textAlign = "center"
      ..textBaseline = "middle"
      ..fillText(stroke, 0, 0)
      ..restore();
    if (moreBubbles) window.animationFrame.then(addBubbles);
  }

  document.body.children.addAll([
    canvas,
    new ButtonElement()
      ..text = "Clear!"
      ..onClick.listen((_) {
        canvas.context2D
          ..fillStyle = "white"
          ..fillRect(0, 0, width, height);
      }),
    new ButtonElement()
      ..text = "Stop!"
      ..onClick.listen((me) {
        var button = me.target as ButtonElement;
        if (moreBubbles) {
          button.text = "Continue!";
          moreBubbles = false;
        } else {
          button.text = "Stop!";
          moreBubbles = true;
          window.animationFrame.then(addBubbles);
        }
      })
  ]);

  window.animationFrame.then(addBubbles);
}
