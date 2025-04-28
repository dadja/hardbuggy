import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:hardbuggy/assetspath.dart';
import 'package:hardbuggy/components/collision_block.dart';
import 'package:hardbuggy/components/good.dart';
import 'package:hardbuggy/habuggygame.dart';
import 'package:hardbuggy/utils/collision_utils.dart';

import 'enemy.dart';

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
  final WordlTileSize = 32;
  double moveSpeed = 32 * 10;
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  Vector2 velocity = Vector2.zero();
  late final int spriteGrid = 16;
  late final int spriteAmountPerRow = 4;
  PlayerDirection playerDirection = PlayerDirection.none;
  bool isFacingRight = true;
  bool isFacingTop = false;
  List<CollisionBlock> collisionBlocks = [];
  bool isLeftKeyPressed = false;
  bool isRightKeyPressed = false;
  bool isUpKeyPressed = false;
  bool isDownKeyPressed = false;

  int horizontalMovement = 0;
  int verticalMovement = 0;

  Player({position})
      : super(
            position: position, size: Vector2(32, 32), anchor: Anchor.topLeft) {
    debugMode = true;
  }

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    debugMode = true;
    add(RectangleHitbox());
    //add player rectangle hitbox..
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
    isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA);
    isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD);
    isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW);
    isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS);

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
    //nullifiy the movement if both keys are pressed
    if (isLeftKeyPressed && isRightKeyPressed) {
      horizontalMovement = 0;
      verticalMovement = 0;
    }
    if (isDownKeyPressed && isUpKeyPressed) {
      horizontalMovement = 0;
      verticalMovement = 0;
    }

    // this is to prevent the player from moving diagonally
    if (isLeftKeyPressed && isUpKeyPressed) {
      playerDirection = PlayerDirection.left;
      horizontalMovement = 0;
      verticalMovement = 0;
    } else if (isLeftKeyPressed && isDownKeyPressed) {
      playerDirection = PlayerDirection.left;
      horizontalMovement = 0;
      verticalMovement = 0;
    } else if (isRightKeyPressed && isUpKeyPressed) {
      playerDirection = PlayerDirection.right;
      horizontalMovement = 0;
      verticalMovement = 0;
    } else if (isRightKeyPressed && isDownKeyPressed) {
      playerDirection = PlayerDirection.right;
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
    velocity =
        Vector2(horizontalMovement.toDouble(), verticalMovement.toDouble());

    //check collision from here ...
    //save this position to be used after checking is ther will be collisions next ..
    final originalPosition = position.clone();
    //get the next movement update
    final movementAfterFrame = velocity * moveSpeed * dt;
    //fake the movement and check collision detection with it to knwo collision will happen ahead before doing the real move ...
    position.add(movementAfterFrame);
    if (verticalMovement < 0) {
      //player moving Up
      final playerNewTop = positionOfAnchor(Anchor.topCenter);
      for (final block in game.world.componentsAtPoint(playerNewTop)) {
        if (block is CollisionBlock) {
          movementAfterFrame.y = 0;
          break;
        }
      }
    }
    if (verticalMovement > 0) {
      //player moving Down
      final playerNewBottom = positionOfAnchor(Anchor.bottomCenter);
      for (final block in game.world.componentsAtPoint(playerNewBottom)) {
        if (block is CollisionBlock) {
          movementAfterFrame.y = 0;
          break;
        }
      }
    }
    if (horizontalMovement < 0) {
      //player moving LEft
      final playerNewLeft = positionOfAnchor(Anchor.centerLeft);
      for (final block in game.world.componentsAtPoint(playerNewLeft)) {
        if (block is CollisionBlock) {
          movementAfterFrame.x = 0;
          break;
        }
      }
    }
    if (horizontalMovement > 0) {
      //player moving right
      final playerNewRight = positionOfAnchor(Anchor.centerRight);
      for (final block in game.world.componentsAtPoint(playerNewRight)) {
        if (block is CollisionBlock) {
          movementAfterFrame.x = 0;
          break;
        }
      }
    }

    //let the player move around ...
    // position += velocity * moveSpeed * dt;
    position = originalPosition + movementAfterFrame;

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

//collisions
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CollisionBlock) {
      // Handle collision with the block
      print('Collision with block detected');
    }
    if (other is Good) {
      print('Collision with Good detected');
      game.onCoinCollected();
      //remove the good and count that all goods got collected..
    }

    if (other is Enemy) {
      //game over ...
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is CollisionBlock) {
      // Handle end of collision with the block
      print('Collision with block ended');
    } else {
      print('Collision with other object ended');
    }
    super.onCollisionEnd(other);
  }
}
