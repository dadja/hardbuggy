import 'package:flutter/material.dart';

import 'space_objects.dart';

class SpacePainter extends CustomPainter {
  final List<Star> stars;
  final List<ShootingStar> shootingStars;
  final List<Planet> planets;
  final List<Nebula> nebulas;

  SpacePainter({
    required this.stars,
    required this.shootingStars,
    required this.planets,
    required this.nebulas,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // 🌌 Draw moving nebulas
    for (var nebula in nebulas) {
      final center = Offset(nebula.x * size.width, nebula.y * size.height);
      final nebulaPaint = Paint()
        ..color = nebula.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
      canvas.drawCircle(center, nebula.radius, nebulaPaint);
    }

    // Draw planets first (in background)
    for (var planet in planets) {
      final center = Offset(planet.x * size.width, planet.y * size.height);

      // 1. Draw glow (blurred circle)
      final glowPaint = Paint()
        ..color = planet.color.withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
      canvas.drawCircle(center, planet.radius * 1.5, glowPaint);

      // 2. Draw solid planet
      final planetPaint = Paint()..color = planet.color;
      canvas.drawCircle(center, planet.radius, planetPaint);
    }


    // Draw stars
    for (var star in stars) {
      paint.color = star.color;
      canvas.drawCircle(Offset(star.x * size.width, star.y * size.height),
          star.radius, paint);
    }

    // Draw shooting stars
    for (var shootingStar in shootingStars) {
      if (shootingStar.isActive) {
        paint.color = shootingStar.color;
        paint.strokeWidth = 2;
        paint.strokeCap = StrokeCap.round;
        canvas.drawLine(
          Offset(shootingStar.x * size.width, shootingStar.y * size.height),
          Offset(
              (shootingStar.x - shootingStar.length / size.width) * size.width,
              (shootingStar.y - shootingStar.length / size.height) *
                  size.height),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
