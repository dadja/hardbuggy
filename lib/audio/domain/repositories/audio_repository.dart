import 'package:hardbuggy/audio/domain/entities/music_type.dart';
import 'package:hardbuggy/audio/domain/entities/sfx_type.dart';

abstract class AudioRepository {
  Future<void> playMusic({MusicType type = MusicType.game});

  Future<void> stopMusic();

  Future<void> playSfx({required SfxType type});

  Future<void> muteAll();

  Future<void> unMuteAll();
}
