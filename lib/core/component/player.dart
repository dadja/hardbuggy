import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:hardbuggy/core/habuggygame.dart';

enum PlayerDirection { up, down, left, right }

enum PlayerState { idle, walking, running, attacking, hurt, dead }

enum PlayerAction { attack, jump, climb, fall }

enum PlayerAnimation {
  idle,
  walkLeft,
  walkRight,
  walkUp,
  walkDown,
  attack,
  hurt,
  die
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
  Vector2 startingPosition = Vector2.zero();
  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;
  Vector2 velocity = Vector2.zero();
  PlayerDirection direction = PlayerDirection.down;
  PlayerState state = PlayerState.walking;
  PlayerAction action = PlayerAction.attack;

  Player() : super(size: Vector2(32, 32));

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  void _loadAllAnimations() {
    spriteSheet = game.images.fromCache('player_128.png');
    //walkLeft Animation
    walkLeftAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4,
        amountPerRow: 4,
        stepTime: stepTime,
        textureSize: Vector2(32, 32),
        texturePosition: Vector2(0, 1 * 32),
        loop: true,
      ),
    );
    //WalkRight Animation
    walkRightAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: stepTime,
        textureSize: Vector2(32, 32),
        texturePosition: Vector2(0, 2 * 32),
        loop: true,
      ),
    );
    //WalkUp Animation
    walkUpAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: stepTime,
        textureSize: Vector2(32, 32),
        texturePosition: Vector2(0, 3 * 32),
        loop: true,
      ),
    );
    //WalkDown Animation
    walkDownAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: stepTime,
        textureSize: Vector2(32, 32),
        texturePosition: Vector2(0, 0 * 32),
        loop: true,
      ),
    );

    animations = {
      PlayerAnimation.walkLeft: walkLeftAnimation,
      PlayerAnimation.walkRight: walkRightAnimation,
      PlayerAnimation.walkUp: walkUpAnimation,
      PlayerAnimation.walkDown: walkDownAnimation,
    };
    current = PlayerAnimation.walkUp;
  }

  SpriteAnimation _spriteAnimation(
    Image imgspriteSheet,
    double animationStepTime,
    int frameamount,
  ) {
    return SpriteAnimation.fromFrameData(
      imgspriteSheet,
      SpriteAnimationData.sequenced(
        amount: frameamount,
        amountPerRow: 4,
        stepTime: animationStepTime,
        textureSize: Vector2(32, 32),
        loop: true,
      ),
    );
  }
}
