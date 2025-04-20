import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:hardbuggy/core/habuggyworld.dart';

class HardBuggyGame extends FlameGame {
  HardBuggyWorld currentWorld = HardBuggyWorld();

  @override
  Future<void> onLoad() async {
    world = currentWorld;
    camera.add(world);
    camera.viewport = FixedResolutionViewport(resolution: Vector2(800, 600));

    super.onLoad();
  }
}
