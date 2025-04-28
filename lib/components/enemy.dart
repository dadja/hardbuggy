import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hardbuggy/assetspath.dart';
import 'package:hardbuggy/components/player.dart';

import '../habuggygame.dart';

class Enemy extends SpriteAnimationGroupComponent
  with HasGameReference<HardBuggyGame>, CollisionCallbacks {
  Enemy({required super.size, required super.position})
      : super(
  anchor: Anchor.topLeft,
  ) {
  debugMode = true;
  }

  late final SpriteAnimation walkLeftAnimation;
  late final SpriteAnimation walkRightAnimation;
  late final SpriteAnimation walkUpAnimation;
  late final SpriteAnimation walkDownAnimation;

  late Image walkSprite0;
  final double stepTime = 0.25;
  final WordlTileSize = 32;
  double moveSpeed = 32 * 5;
  Vector2 velocity = Vector2.zero();
  PlayerDirection playerDirection = PlayerDirection.down;
  bool isFacingRight = true;
  bool isFacingTop = false;


  @override
  FutureOr<void> onLoad() async {
    debugMode =true;
    _loadAllAnimations();
  add(RectangleHitbox(
  collisionType: CollisionType.active,
  ));
  await super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

  }

  void _loadAllAnimations() {
    //walkLeft Animation
    walkLeftAnimation = SpriteAnimation.spriteList([
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}13.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}14.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}15.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}00.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
    ], stepTime: stepTime,);
    //WalkRight Animation
    walkRightAnimation = SpriteAnimation.spriteList([
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}09.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}10.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}11.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}12.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
    ], stepTime: stepTime,);
    //WalkUp Animation
    walkUpAnimation = SpriteAnimation.spriteList([
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}05.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}06.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}07.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}08.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
    ], stepTime: stepTime,);
    //WalkDown Animation
    walkDownAnimation = SpriteAnimation.spriteList([
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}01.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}02.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}03.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
      Sprite(game.images.fromCache("${AssetsPaths.enemyPath}04.png"),srcPosition: Vector2(0,0),srcSize: Vector2(32,32)),
    ], stepTime: stepTime,);

    animations = {
      PlayerAnimation.walkLeft: walkLeftAnimation,
      PlayerAnimation.walkRight: walkRightAnimation,
      PlayerAnimation.walkUp: walkUpAnimation,
      PlayerAnimation.walkDown: walkDownAnimation,
    };
    current = PlayerAnimation.walkDown;
  }
}