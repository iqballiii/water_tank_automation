import 'package:flutter/material.dart';

class WaterTankPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint1 = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    //1 Draw the left border of the tank
    canvas.drawLine(Offset(size.width * 0.1, -size.height * .03),
        Offset(size.width * 0.1, size.height * 1), borderPaint1);

    // Draw the bottom border of the tank.
    canvas.drawLine(Offset(size.width * 0.1, size.height * 1),
        Offset(size.width * 0.8, size.height * 1), borderPaint1);

    //3 Draw the right border of the tank
    canvas.drawLine(Offset(size.width * 0.8, size.height * 1),
        Offset(size.width * 0.8, -size.height * .03), borderPaint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
//                -
// |           |  '
// |           |  '
// |           |  '
// |           |  ' --->  mediasize.height *1 + 10
// |           |  '
// |           |  '
// |___________|  '
//| ----------- | -
//  mediasize.width*0.8
