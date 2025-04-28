import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hardbuggy/habuggygame.dart';

class Good extends SpriteComponent
    with
        HasGameReference<HardBuggyGame>,
        CollisionCallbacks {
  Good({
    required super.sprite,
    required super.size,
    required super.position,
  }) : super(
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
