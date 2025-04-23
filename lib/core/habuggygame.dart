import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:hardbuggy/core/component/player.dart';
import 'package:hardbuggy/worlds/world/levels/level.dart';

class HardBuggyGame extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF000000);

  Player player = Player();
  List<String> levelNames = [
    'Level-01.tmx',
    'Level-02.tmx',
    'Level-03.tmx',
  ];
  int currentLevelIndex = 2;

  @override
  Future<void> onLoad() async {
    //this is to keep images in cache once all loaded
    await images.loadAllImages();
    world = Level(levelName: levelNames[currentLevelIndex], player: player);
    camera.viewfinder.anchor = Anchor.center;
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

    player.position = Vector2(400, 100);
    player.size = Vector2(32, 32);
    player.anchor = Anchor.topLeft;
    camera.follow(player);
    return super.onLoad();
  }
}
