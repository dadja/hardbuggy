import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hardbuggy/components/worlds/world/levels/level.dart';
import 'package:hardbuggy/components/player.dart';
import 'package:hardbuggy/theme/pallet_color.dart';

import 'audio/audio_controller.dart';
import 'audio/domain/entities/music_type.dart';
import 'audio/domain/entities/sfx_type.dart';
import 'menu/domain/entities/menu_type.dart';

class HardBuggyGame extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  final AudioController audioController;

  HardBuggyGame(this.audioController);

  @override
  Color backgroundColor() => const Color(0xFF000000);

  static JoystickComponent joystick = JoystickComponent(
    size: 100,
    knob: CircleComponent(
        radius: 20, paint: Paint()..color = PalletColor.secondaryColor),
    background: CircleComponent(
        radius: 40, paint: Paint()..color = PalletColor.primaryColor),
    margin: EdgeInsets.only(left: 20, bottom: 20),
  );

  bool showJoyStick = false;

  bool hasStarted = false;

  List<String> levelNames = [
    'Level-01',
    'Level-02',
    'Level-03',
    'Level-04',
  ];
  int currentLevelIndex = 0;
  Player player = Player();

  @override
  Future<void> onLoad() async {
    audioController.playMusic();
    overlays.add(MenuType.main.name);
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

  void onPlayerHit() {
    audioController.playSfx(type: SfxType.hit);
  }

  void onCoinCollected() {
    audioController.playSfx(type: SfxType.coin);
  }

  void onPause() {
    audioController.stopMusic();
  }

  void onResume() {
    audioController.playMusic();
  }

  Future<void> startGame() async {
    if (!hasStarted) {
      overlays.remove(MenuType.main.name);
      audioController.playMusic(type: MusicType.game);
      hasStarted = true;
      //this is to keep images in cache once all loaded
      await images.loadAllImages();
      camera.viewfinder.anchor = Anchor.center;
      camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));
      // camera.setBounds(bounds: Rect.fromLTRB(0, 0, 800, 600));
      if (showJoyStick) camera.viewport.add(joystick);
      loadLevel();
    }
  }
}
