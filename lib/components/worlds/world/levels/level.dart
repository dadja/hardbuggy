import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/foundation.dart';
import 'package:hardbuggy/assetspath.dart';
import 'package:hardbuggy/components/collision_block.dart';
import 'package:hardbuggy/components/player.dart';
import 'package:hardbuggy/habuggygame.dart';

class Level extends World with HasGameReference<HardBuggyGame> {
  final String levelName;
  final Player player;
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];
  // List<Enemy> enemies = [];

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(levelName, Vector2.all(32));
    final spawnPointLayer = level.tileMap
        .getLayer<ObjectGroup>(TileMapLayers.playerObjectGroupLayerName);
    final collisionLayer = level.tileMap
        .getLayer<ObjectGroup>(TileMapLayers.collisionsObjectGroupLayerName);

    if (spawnPointLayer == null) {
      print('Spawn point layer not found');
      return;
    }
    if (collisionLayer == null) {
      print('Collision layer not found');
      return;
    }

    for (final collision in collisionLayer.objects) {
      final collisionBlock = CollisionBlock(
        size: collision.size,
        position: collision.position,
      );
      collisionBlocks.add(collisionBlock);
      // add(collisionBlock);

      //  switch (collision.class_) {
      //   // case 'collision':
      //   //   add(RectangleHitbox(
      //   //     size: collision.size,
      //   //     position: collision.position,
      //   //     anchor: Anchor.center,
      //   //   ));
      //   //   break;
      //   default:
      //     break;
    }

    for (final spawnPoint in spawnPointLayer.objects) {
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
    //collision blocks should be added after the level
    for (final collisionBlock in collisionBlocks) {
      add(collisionBlock);
    }
    //add player to the world
    add(player);
    // add(RectangleHitbox(
    //   size: player.size,
    //   position: player.position,
    // ));
    //pass collsion data to the player class
    player.collisionBlocks = collisionBlocks;
    // HudButtonComponent()
    return super.onLoad();
  }
}
