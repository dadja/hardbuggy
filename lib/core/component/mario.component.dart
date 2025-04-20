import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:hardbuggy/core/assetspath.dart';

class MarioComponent extends SpriteComponent with TapCallbacks {
  MarioComponent({super.position})
      : super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(AssetsPaths.playerPath);
  }

  @override
  void onTapUp(TapUpEvent event) {
    size += Vector2.all(50);
  }
}
