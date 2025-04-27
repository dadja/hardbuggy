import 'dart:math';
import 'package:flutter/material.dart';

class Star {
  double x;
  double y;
  double radius;
  Color color;
  double speed;
  final Random random = Random();

  Star()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        radius = Random().nextDouble() * 1.5,
        color = Colors.white.withValues(alpha: Random().nextDouble()),
        speed = Random().nextDouble() * 0.0005 + 0.0002;

  void update() {
    x += speed;
    if (x > 1) {
      x = 0;
      y = random.nextDouble();
      radius = random.nextDouble() * 1.5;
      color = Colors.white.withValues(alpha: random.nextDouble());
    }
  }
}

class ShootingStar {
  double x;
  double y;
  double length;
  double speedX;
  double speedY;
  Color color;
  bool isActive;
  final Random random = Random();

  ShootingStar()
      : x = Random().nextDouble(),
        y = Random().nextDouble() * 0.3,
        length = Random().nextDouble() * 80 + 40,
        speedX = Random().nextDouble() * 0.01 + 0.005,
        speedY = Random().nextDouble() * 0.01 + 0.005,
        color = Colors.white.withValues(alpha: 0.8),
        isActive = false;

  void activate() {
    x = random.nextDouble();
    y = random.nextDouble() * 0.3;
    speedX = random.nextDouble() * 0.01 + 0.005;
    speedY = random.nextDouble() * 0.01 + 0.005;
    length = random.nextDouble() * 80 + 40;
    color = Colors.white.withValues(alpha: 0.8);
    isActive = true;
  }

  void update() {
    if (isActive) {
      x += speedX;
      y += speedY;
      if (x > 1 || y > 1) {
        isActive = false;
      }
    }
  }
}

class Planet {
  double x;
  double y;
  double radius;
  double speed;
  Color color;
  final Random random = Random();

  Planet()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        radius = Random().nextDouble() * 100 + 50,
        speed = Random().nextDouble() * 0.0002 + 0.00005,
        color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
            .withValues(alpha: 0.2);

  void update() {
    x += speed;
    if (x > 1.5) {
      x = -0.5;
      y = random.nextDouble();
      radius = random.nextDouble() * 100 + 50;
      color = Colors.primaries[random.nextInt(Colors.primaries.length)]
          .withValues(alpha: 0.2);
    }
  }
}

class Nebula {
  double x;
  double y;
  double radius;
  double speedX;
  double speedY;
  Color color;
  final Random random = Random();

  Nebula()
      : x = Random().nextDouble(),
        y = Random().nextDouble(),
        radius = Random().nextDouble() * 300 + 150,
        speedX = (Random().nextDouble() - 0.5) * 0.0002,
        speedY = (Random().nextDouble() - 0.5) * 0.0002,
        color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
            .withValues(alpha: 0.1);

  void update() {
    x += speedX;
    y += speedY;
    if (x < -0.5 || x > 1.5) speedX = -speedX;
    if (y < -0.5 || y > 1.5) speedY = -speedY;
  }
}
