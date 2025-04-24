import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hardbuggy/components/worlds/world/levels/level.dart';
import 'package:hardbuggy/components/player.dart';

class HardBuggyGame extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF000000);

  late JoystickComponent joystick;
  bool showJoyStick = true;

  List<String> levelNames = [
    'Level-01',
    'Level-02',
    'Level-03',
  ];
  int currentLevelIndex = 2;
  Player player = Player();

  @override
  Future<void> onLoad() async {
    //this is to keep images in cache once all loaded
    await images.loadAllImages();
    camera.viewfinder.anchor = Anchor.center;
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));
    // camera.setBounds(bounds: Rect.fromLTRB(0, 0, 800, 600));
    if (showJoyStick) addJoyStick();
    loadLevel();

    return super.onLoad();
  }

  @override
  update(double dt) {
    if (showJoyStick) {
      updateJoyStick();
    }
    super.update(dt);
  }

  loadLevel() {
    if (currentLevelIndex < levelNames.length) {
      world = Level(
        player: player,
        levelName: '${levelNames[currentLevelIndex]}.tmx',
      );
      currentLevelIndex++;
    } else {
      // Handle game completion or reset logic here
    }
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      size: 100,
      knob: CircleComponent(
          radius: 20, paint: Paint()..color = const Color(0xFF00FF00)),
      background: CircleComponent(
          radius: 40, paint: Paint()..color = const Color(0xFF0000FF)),
      margin: EdgeInsets.only(left: 20, bottom: 20),
    );
    camera.viewport.add(joystick);
  }

  void updateJoyStick() {
    switch (joystick.direction) {
      case JoystickDirection.up:
        player.playerDirection = PlayerDirection.up;
        player.isFacingTop = true;
        player.horizontalMovement = 0;
        player.verticalMovement = -1;
        break;
      case JoystickDirection.down:
        player.playerDirection = PlayerDirection.down;
        player.isFacingTop = false;
        player.horizontalMovement = 0;
        player.verticalMovement = 1;
        break;
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        player.isFacingRight = false;
        player.horizontalMovement = -1;
        player.verticalMovement = 0;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        player.isFacingRight = true;
        player.horizontalMovement = 1;
        player.verticalMovement = 0;
        break;
      case JoystickDirection.idle:
        player.playerDirection = PlayerDirection.none;
        player.isFacingRight = true;
        player.isFacingTop = false;
        player.horizontalMovement = 0;
        player.verticalMovement = 0;
        break;
    }
  }
}
