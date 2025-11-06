import 'package:flutter/material.dart';

class QuizBackgroundPainter extends CustomPainter {
  final Color topColor;
  final Color bottomColor;

  QuizBackgroundPainter({
    required this.topColor,
    required this.bottomColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // --- 1. Path for the TOP section (red/dark red) ---
    // This path should start at top-left, curve down,
    // and then go all the way to the bottom-left before closing,
    // ensuring it covers the entire upper area.
    final Path topPath = Path();
    topPath.lineTo(0, size.height * 0.4); // Start at top-left, go down to 40% height
    topPath.quadraticBezierTo(
      size.width * 0.5, // Control point X (middle of the screen)
      size.height * 0.5, // Control point Y (slightly below the 40% line to create the curve)
      size.width,        // End point X (right edge)
      size.height * 0.4, // End point Y (back up to 40% height on the right)
    );
    topPath.lineTo(size.width, 0); // Go up to top-right
    topPath.close(); // Close the path back to top-left

    // Paint for the top section
    final Paint topPaint = Paint()..color = topColor;
    canvas.drawPath(topPath, topPaint);


    // --- 2. Path for the BOTTOM section (off-white/dark grey) ---
    // This path should start exactly where the topPath's curve ends
    // and fill the remaining bottom area.
    final Path bottomPath = Path();
    bottomPath.moveTo(0, size.height * 0.4); // Start where the top path ended on the left
    bottomPath.quadraticBezierTo(
      size.width * 0.5, // Control point X (middle of the screen)
      size.height * 0.5, // Control point Y (same control point as top path for a smooth curve)
      size.width,        // End point X (right edge)
      size.height * 0.4, // End point Y (where the top path ended on the right)
    );
    bottomPath.lineTo(size.width, size.height); // Go down to bottom-right
    bottomPath.lineTo(0, size.height); // Go to bottom-left
    bottomPath.close(); // Close the path back to start (bottom-left)

    // Paint for the bottom section
    final Paint bottomPaint = Paint()..color = bottomColor;
    canvas.drawPath(bottomPath, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Only repaint if colors change
    return (oldDelegate as QuizBackgroundPainter).topColor != topColor ||
           (oldDelegate as QuizBackgroundPainter).bottomColor != bottomColor;
  }
}