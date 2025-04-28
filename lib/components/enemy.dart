import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hardbuggy/assetspath.dart';
import 'package:hardbuggy/components/player.dart';
import 'package:hardbuggy/utils.dart';

import '../habuggygame.dart';
import 'collision_block.dart';

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
  Vector2 startPosition = Vector2.zero();
  late Image walkSprite0;
  final double stepTime = 0.25;
  double moveSpeed = mapTileSize * 2;
  Vector2 velocity = Vector2.zero();
  PlayerDirection playerDirection = PlayerDirection.down;
  bool isFacingRight = true;
  bool isFacingTop = false;
  bool isFacingLeft = false;
  bool isFacingBottom = false;
  double horizontalMovement = 0;
  double verticalMovement = 0;

  @override
  FutureOr<void> onLoad() {

    var random = Random();
    isFacingTop = random.nextBool();
    if(isFacingTop){
      playerDirection = PlayerDirection.up;
      verticalMovement = -1;
    }else{
      playerDirection = PlayerDirection.down;
      verticalMovement = 1;
    }
    //=====>
    debugMode = true;
    moveSpeed = mapTileSize * Random().nextInt(4);
    _loadAllAnimations();
    add(RectangleHitbox(
      collisionType: CollisionType.active,
    ));
    return super.onLoad();
  }

  void _updateEnemyMovement(double dt) {

    velocity = Vector2(horizontalMovement, verticalMovement);
    final originalPosition = position.clone();
    //get the next movement update
    var movementAfterFrame = moveSpeed *verticalMovement * dt;
    if (verticalMovement < 0) {
      //enemy moving Up
      final enemyNewTop = positionOfAnchor(Anchor.topCenter);
      for (final block in game.world.componentsAtPoint(enemyNewTop)) {
        if (block is CollisionBlock) {
          verticalMovement = 1;
          playerDirection = PlayerDirection.down;
          current = PlayerAnimation.walkDown;
          movementAfterFrame = movementAfterFrame * verticalMovement;
          break;
        }
      }
    }
    if (verticalMovement > 0) {
      //enemy moving Down
      final enemyNewBottom = positionOfAnchor(Anchor.bottomCenter);
      for (final block in game.world.componentsAtPoint(enemyNewBottom)) {
        if (block is CollisionBlock) {
          verticalMovement =-1;
          playerDirection = PlayerDirection.up;
          current = PlayerAnimation.walkUp;
          movementAfterFrame =  movementAfterFrame * verticalMovement;
          break;
        }
      }
    }
    super.position.y = originalPosition.y + movementAfterFrame;
  }

  @override
  void update(double dt) {
    _updateEnemyMovement(dt);
    // position += velocity * moveSpeed *dt;
    super.update(dt);
  }

  void _loadAllAnimations() {
    //walkLeft Animation
    walkLeftAnimation = SpriteAnimation.spriteList(
      [
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}13.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}14.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}15.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}00.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
      ],
      stepTime: stepTime,
    );
    //WalkRight Animation
    walkRightAnimation = SpriteAnimation.spriteList(
      [
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}09.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}10.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}11.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}12.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
      ],
      stepTime: stepTime,
    );
    //WalkUp Animation
    walkUpAnimation = SpriteAnimation.spriteList(
      [
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}05.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}06.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}07.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}08.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
      ],
      stepTime: stepTime,
    );
    //WalkDown Animation
    walkDownAnimation = SpriteAnimation.spriteList(
      [
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}01.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}02.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}03.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
        Sprite(game.images.fromCache("${AssetsPaths.enemyPath}04.png"),
            srcPosition: Vector2(0, 0), srcSize: Vector2.all(mapTileSize)),
      ],
      stepTime: stepTime,
    );

    animations = {
      PlayerAnimation.walkLeft: walkLeftAnimation,
      PlayerAnimation.walkRight: walkRightAnimation,
      PlayerAnimation.walkUp: walkUpAnimation,
      PlayerAnimation.walkDown: walkDownAnimation,
    };
    current = PlayerAnimation.walkDown;
  }
}
