import 'package:haatinhandseller/constans/app_config/app_color_constants.dart';
import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColorConstant.greyColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    double dashWidth = 8;
    double dashSpace = 4;
    double startX = 0;

    while (startX < size.width - dashSpace) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLinePainter(),
    );
  }
}
