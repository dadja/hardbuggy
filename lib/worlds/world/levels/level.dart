import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:hardbuggy/core/component/player.dart';
import 'package:hardbuggy/core/habuggygame.dart';

class Level extends World with HasGameReference<HardBuggyGame> {
  final String levelName;
  final Player player;
  late TiledComponent level;
  final JoystickComponent joystick;
  final String objectGroupLayerName = 'spawnpoints';

  Level(
      {required this.levelName, required this.player, required this.joystick});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(levelName, Vector2.all(32));
    final spawnPointLayer =
        level.tileMap.getLayer<ObjectGroup>(objectGroupLayerName);

    for (final spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
          player.position = spawnPoint.position;
          player.size = Vector2(32, 32);
          player.anchor = Anchor.center;
          game.camera.follow(player);
          break;
        case 'enemy':
          // Handle enemy spawn point
          break;
        default:
          break;
      }
    }
    //adding component in order in the world matters...
    add(level);
    add(player);
    // HudButtonComponent()
    return super.onLoad();
  }
}
