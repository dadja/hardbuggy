import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hardbuggy/habuggygame.dart';

class Gate extends PositionComponent   with HasGameReference<HardBuggyGame>, CollisionCallbacks {
  Gate({required super.size, required super.position})
      : super(
    anchor: Anchor.topLeft,
  ) {
    // debugMode = true;
  }

  @override
  FutureOr<void> onLoad() async {
    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
    await super.onLoad();
  }
}
