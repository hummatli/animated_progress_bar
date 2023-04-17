import 'package:flutter/material.dart';

//Custom painter to draw animated background for Custom ProgressIndicator.
class AnimatedStripesPainter extends CustomPainter {
  final double offset;
  final double stripeWidth;
  final double stripeSpacing;

  AnimatedStripesPainter({
    required this.offset,
    required this.stripeWidth,
    required this.stripeSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final int numberOfStripes =
        (size.width / (stripeWidth + stripeSpacing)).ceil() + 1;

    Paint stripePaint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.fill;

    for (int i = 0; i < numberOfStripes; i++) {
      double startX = (stripeWidth + stripeSpacing) * i - offset - 10;
      Path stripePath = Path()
        ..moveTo(startX, 0)
        ..lineTo(startX + stripeWidth, 0)
        ..lineTo(startX + stripeWidth * 2, size.height)
        ..lineTo(startX + stripeWidth, size.height)
        ..close();
      canvas.drawPath(stripePath, stripePaint);
    }
  }

  @override
  bool shouldRepaint(covariant AnimatedStripesPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }
}
