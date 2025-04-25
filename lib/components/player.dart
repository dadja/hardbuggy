import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:hardbuggy/assetspath.dart';
import 'package:hardbuggy/habuggygame.dart';

enum PlayerAnimation {
  walkLeft,
  walkRight,
  walkUp,
  walkDown,
  // attack,
  // hurt,
  // die
}

enum PlayerDirection {
  left,
  right,
  up,
  down,
  none,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameReference<HardBuggyGame>, KeyboardHandler, CollisionCallbacks {
  // late final SpriteAnimation idle;
  late final SpriteAnimation walkLeftAnimation;
  late final SpriteAnimation walkRightAnimation;
  late final SpriteAnimation walkUpAnimation;
  late final SpriteAnimation walkDownAnimation;
  late Image spriteSheet;
  final double stepTime = 0.25;
  double moveSpeed = 100;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  Vector2 velocity = Vector2.zero();
  late final int spriteGrid = 16;
  late final int spriteAmountPerRow = 4;
  PlayerDirection playerDirection = PlayerDirection.none;
  bool isFacingRight = true;
  bool isFacingTop = false;

  int horizontalMovement = 0;
  int verticalMovement = 0;

  Player({position}) : super(position: position, size: Vector2(32, 32));

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (game.showJoyStick) return false;
    final isLeftKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
            keysPressed.contains(LogicalKeyboardKey.keyA);
    final isRightKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
            keysPressed.contains(LogicalKeyboardKey.keyD);
    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW);
    final isDownKeyPressed =
        keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
            keysPressed.contains(LogicalKeyboardKey.keyS);

    if (isLeftKeyPressed && isRightKeyPressed) {
      horizontalMovement = 0;
      verticalMovement = 0;
    }
    if (isDownKeyPressed && isUpKeyPressed) {
      horizontalMovement = 0;
      verticalMovement = 0;
    }
    if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
      horizontalMovement = -1;
      verticalMovement = 0;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
      horizontalMovement = 1;
      verticalMovement = 0;
    } else if (isUpKeyPressed) {
      playerDirection = PlayerDirection.up;
      horizontalMovement = 0;
      verticalMovement = -1;
    } else if (isDownKeyPressed) {
      playerDirection = PlayerDirection.down;
      horizontalMovement = 0;
      verticalMovement = 1;
    } else {
      playerDirection = PlayerDirection.none;
      horizontalMovement = 0;
      verticalMovement = 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    spriteSheet = game.images.fromCache(AssetsPaths.playerPath);
    //walkLeft Animation
    walkLeftAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.range(
        start: 4,
        end: 7,
        amount: spriteGrid,
        amountPerRow: spriteAmountPerRow,
        stepTimes: List.generate(
          4,
          (index) => index == 0 ? stepTime : stepTime * 0.5,
        ),
        textureSize: Vector2(32, 32),
      ),
    );
    //WalkRight Animation
    walkRightAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.range(
        start: 8,
        end: 11,
        amount: spriteGrid,
        amountPerRow: spriteAmountPerRow,
        stepTimes: List.generate(
          4,
          (index) => index == 0 ? stepTime : stepTime * 0.5,
        ),
        textureSize: Vector2(32, 32),
      ),
    );
    //WalkUp Animation
    walkUpAnimation = SpriteAnimation.fromFrameData(
        spriteSheet,
        SpriteAnimationData.range(
          start: 12,
          end: 15,
          amount: spriteGrid,
          amountPerRow: spriteAmountPerRow,
          stepTimes: List.generate(
            4,
            (index) => index == 0 ? stepTime : stepTime * 0.5,
          ),
          textureSize: Vector2(32, 32),
        ));
    //WalkDown Animation
    walkDownAnimation = SpriteAnimation.fromFrameData(
        spriteSheet,
        SpriteAnimationData.range(
          start: 0,
          end: 3,
          amount: spriteGrid,
          amountPerRow: spriteAmountPerRow,
          stepTimes: List.generate(
            4,
            (index) => index == 0 ? stepTime : stepTime * 0.5,
          ),
          textureSize: Vector2(32, 32),
        ));

    animations = {
      PlayerAnimation.walkLeft: walkLeftAnimation,
      PlayerAnimation.walkRight: walkRightAnimation,
      PlayerAnimation.walkUp: walkUpAnimation,
      PlayerAnimation.walkDown: walkDownAnimation,
    };
    current = PlayerAnimation.walkRight;
  }

  void _updatePlayerMovement(double dt) {
    velocity =
        Vector2(horizontalMovement.toDouble(), verticalMovement.toDouble());
    //let the player move around ...
    position += velocity * moveSpeed * dt;
    if (velocity == Vector2.zero()) {
      current = PlayerAnimation.walkRight;
    } else {
      switch (playerDirection) {
        case PlayerDirection.left:
          current = PlayerAnimation.walkLeft;
          break;
        case PlayerDirection.right:
          current = PlayerAnimation.walkRight;
          break;
        case PlayerDirection.up:
          current = PlayerAnimation.walkUp;
          break;
        case PlayerDirection.down:
          current = PlayerAnimation.walkDown;
          break;
        default:
          break;
      }
    }
  }
}
