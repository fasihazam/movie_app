// Curved Screen (A static screen design at the top)
import 'package:flutter/material.dart';
import 'package:movie_app/core/config/app_colors.dart';

class CurvedScreen extends StatelessWidget {
  final ScrollController screenScrollController;
  final double screenWidth;

  const CurvedScreen({
    super.key,
    required this.screenScrollController,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: screenScrollController,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: CustomPaint(
        size: Size(screenWidth, 100),
        painter: const ScreenPainter(),
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  const ScreenPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.inputBorder
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * -0.05, size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
