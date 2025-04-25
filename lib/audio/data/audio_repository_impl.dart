import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import '../domain/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  bool _muted = false;
  final List<String> _bgmTracks = ['music.mp3', 'music.mp3', 'music.mp3'];

  final Random _random = Random();

  @override
  Future<void> playBackgroundMusic() async {
    if (_muted) return;
    await FlameAudio.bgm.initialize();
    final track = _bgmTracks[_random.nextInt(_bgmTracks.length)];
    await FlameAudio.bgm.play("music/$track");
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
