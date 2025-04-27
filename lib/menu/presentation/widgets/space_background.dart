import 'dart:math';
import 'package:flutter/material.dart';

import 'space_objects.dart';
import 'space_painter.dart';

class SpaceBackground extends StatefulWidget {
  const SpaceBackground({super.key});

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> _stars;
  late List<ShootingStar> _shootingStars;
  late List<Planet> _planets;
  late List<Nebula> _nebulas;

  final int numStars = 200;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 60))
          ..repeat();
    _stars = List.generate(numStars, (_) => Star());
    _shootingStars = List.generate(5, (_) => ShootingStar());
    _planets = List.generate(3, (_) => Planet());
    _nebulas = List.generate(5, (_) => Nebula());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var star in _stars) {
          star.update();
        }
        for (var shootingStar in _shootingStars) {
          if (!shootingStar.isActive && Random().nextDouble() < 0.005) {
            shootingStar.activate();
          }
          shootingStar.update();
        }
        for (var planet in _planets) {
          planet.update();
        }
        for (var nebula in _nebulas) {
          nebula.update();
        }

        return CustomPaint(
          painter: SpacePainter(
            stars: _stars,
            shootingStars: _shootingStars,
            planets: _planets,
            nebulas: _nebulas,
          ),
          child: Container(),
        );
      },
    );
  }
}
