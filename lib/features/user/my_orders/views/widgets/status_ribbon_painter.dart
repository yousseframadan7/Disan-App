import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class StatusRibbonPainter extends CustomPainter {
  final String text;
  final Color color;

  StatusRibbonPainter({required this.text, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw ribbon with folded effect
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Gradient for premium look
    final gradient = LinearGradient(
      colors: [color, color.withOpacity(0.7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    paint.shader = gradient;

    // Draw ribbon shape with folded effect, adjusted for smaller height
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - 25, 0)
      ..lineTo(size.width, 15) // Adjusted fold effect
      ..lineTo(size.width - 25, 30)
      ..lineTo(0, 30)
      ..lineTo(25, 15) // Adjusted fold effect on left
      ..close();
    canvas.drawShadow(path, Colors.black45, 4.0, false);
    canvas.drawPath(path, paint);
    final textSpan = TextSpan(
      text: text.toUpperCase(),
      style: AppTextStyles.title12WhiteBold,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 1,
      ellipsis: '...', // Clip long text
    );
    textPainter.layout(
        maxWidth: size.width - SizeConfig.width * 0.1);
    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    // Center text within the ribbon with padding
    final offset = Offset(
      (size.width - textWidth) / 2,
      (30 - textHeight) / 2, // Use ribbon height (30) for vertical centering
    );

    // Clip text to prevent overflow
    canvas.save();
    canvas.clipPath(path);
    textPainter.paint(canvas, offset);
    canvas.restore();
  }

  Ascending(CustomPainter oldDelegate) => true;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
