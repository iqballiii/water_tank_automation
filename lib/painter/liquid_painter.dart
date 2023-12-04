import 'dart:math';
import 'package:flutter/material.dart';

/// A custom painter that creates a liquid-like animation using a sine wave.
class LiquidPainter extends CustomPainter {
  final double value;
  final double maxValue;

  /// Creates a [LiquidPainter] with the given [value] and [maxValue].
  LiquidPainter(this.value, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    double heightOfWater = size.height * 1;
    double diameter = size.width * 0.8 - 5.0;
    double radius = diameter / 2;

    // Defining coordinate points. The wave starts from the bottom and ends at the top as the value changes.
    double pointX = size.width * 0.1 + 5.0;
    double pointY = heightOfWater -
        ((diameter + 10) *
            (value /
                maxValue)); // 10 is an extra offset added to fill the circle completely

    Path path = Path();
    path.moveTo(pointX, pointY);

    // Amplitude: the height of the sine wave
    double amplitude = 10;

    // Period: the time taken to complete one full cycle of the sine wave.
    // f = 1/p, the more the value of the period, the higher the frequency.
    double period = value / maxValue;

    // Phase Shift: the horizontal shift of the sine wave along the x-axis.
    double phaseShift = value * pi;

    // Plotting the sine wave by connecting various paths till it reaches the diameter.
    // Using this formula: y = A * sin(ωt + φ) + C
    for (double i = 0; i <= diameter; i++) {
      path.lineTo(
        i + pointX,
        pointY + amplitude * sin((i * 2 * period * pi / diameter) + phaseShift),
      );
    }

    // Calculate the start and sweep angles to draw the progress arc.
    path.lineTo(pointX + diameter, diameter);
    path.lineTo(pointX, diameter);
    // Closing the path.
    path.close();

    Paint paint = Paint()
      ..shader = SweepGradient(
              colors: [
                Colors.blue,
                Colors.blue.shade400,
                Colors.blue.shade800
                // Color(0xffFF7A01),
                // Color(0xffFF0069),
                // Color(0xff7639FB),
              ],
              startAngle: pi / 2,
              endAngle: 5 * pi / 2,
              tileMode: TileMode.clamp,
              stops: [
                0.25,
                0.35,
                0.5,
              ])
          .createShader(Rect.fromCircle(
              center: Offset(diameter, diameter), radius: radius))
      ..style = PaintingStyle.fill;

    // Clipping rectangular-shaped path.
    Path rectangleClip = Path()
      // ..addRect(Rect.fromPoints(Offset(50, 5), Offset(size.width * 0.6, 5)));
      ..addRect(Rect.fromCenter(
          center: Offset(size.width * 0.4, size.height * 0.5),
          width: diameter,
          height: heightOfWater));
    canvas.clipPath(rectangleClip, doAntiAlias: true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
