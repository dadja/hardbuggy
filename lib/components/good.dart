import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hardbuggy/habuggygame.dart';

class Good extends PositionComponent
    with HasGameReference<HardBuggyGame>, CollisionCallbacks {
  Good({required super.size, required super.position})
      : super(
    anchor: Anchor.topLeft,
  ) {
    debugMode = true;
  }

  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
    await super.onLoad();

  }
}