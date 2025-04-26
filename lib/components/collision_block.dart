import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hardbuggy/habuggygame.dart';

class CollisionBlock extends PositionComponent
    with HasGameReference<HardBuggyGame>, CollisionCallbacks {
  CollisionBlock({required super.size, required super.position})
      : super(
          anchor: Anchor.topLeft,
        ) {
    debugMode = true;
  }

  @override
  FutureOr<void> onLoad() async {
    // (game as HasCollisionDetection)
    //     .collisionDetection
    //     .collisionsCompletedNotifier
    //     .addListener(() {
    // resolveCollisions();
    // });
    await super.onLoad();
    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
  }
}
