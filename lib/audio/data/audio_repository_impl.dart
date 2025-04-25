import 'package:flame_audio/flame_audio.dart';
import '../domain/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  bool _muted = false;

  @override
  Future<void> playBackgroundMusic() async {
    if (_muted) return;
    await FlameAudio.bgm.initialize();
    await FlameAudio.bgm.play('music/music.mp3');
  }

  @override
  Future<void> stopBackgroundMusic() async {
    await FlameAudio.bgm.stop();
  }

  @override
  Future<void> playSfx(String fileName) async {
    if (_muted) return;
    await FlameAudio.play(fileName);
  }

  @override
  Future<void> muteAll() async {
    _muted = true;
    await FlameAudio.bgm.stop();
  }

  @override
  Future<void> unMuteAll() async {
    _muted = false;
    await playBackgroundMusic();
  }
}
