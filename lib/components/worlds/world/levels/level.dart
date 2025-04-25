import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:hardbuggy/components/player.dart';
import 'package:hardbuggy/habuggygame.dart';

class Level extends World with HasGameReference<HardBuggyGame> {
  final String levelName;
  final Player player;
  late TiledComponent level;
  final String playerObjectGroupLayerName = 'spawnpoints';
  final String collisionsObjectGroupLayerName = 'collisions';

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(levelName, Vector2.all(32));
    final spawnPointLayer =
        level.tileMap.getLayer<ObjectGroup>(playerObjectGroupLayerName);
    final collisionLayer =
        level.tileMap.getLayer<ObjectGroup>(collisionsObjectGroupLayerName);

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
