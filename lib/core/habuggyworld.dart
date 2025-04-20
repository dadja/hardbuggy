import 'package:flame/components.dart';
import 'package:hardbuggy/core/component/mario.component.dart';

class HardBuggyWorld extends World {
  @override
  Future<void> onLoad() async {
    add(MarioComponent(position: Vector2(10, 10)));
  }
}
