import 'package:hardbuggy/components/collision_block.dart';

import 'package:hardbuggy/components/player.dart';

bool checkCollision(Player player ,CollisionBlock block){
  final playerX= player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.size.x;
  final playerHeight = player.size.y;

  final blockX = block.position.x;
  final blockY = block.position.y;
  final blockWidth = block.size.x;
  final blockHeight = block.size.y;

   return (playerY < blockY +blockHeight && playerY+playerHeight > blockY && playerX < blockX + blockWidth && playerX + playerWidth > blockX );
}