import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:hardbuggy/audio/domain/entities/sfx_type.dart';
import '../../domain/entities/music_type.dart';
import '../../domain/repositories/audio_repository.dart';

class AudioRepositoryImpl implements AudioRepository {
  bool _muted = false;
  final Random _random = Random();
  final Map<MusicType, List<String>> _musicTracks = {
    MusicType.menu: ['menu1.mp3'],
    MusicType.game: ['game1.mp3', 'game2.mp3'],
    MusicType.win: ['win1.mp3'],
    MusicType.lose: ['lose1.mp3'],
  };

  final Map<SfxType, List<String>> _sfxTracks = {
    SfxType.hit: ['hit1.wav', 'hit2.wav'],
    SfxType.coin: ['coin1.wav', 'coin2.wav'],
    SfxType.menu: ['coin2.wav'],
  };

  @override
  Future<void> playMusic({MusicType type = MusicType.game}) async {
    if (_muted) return;

    await FlameAudio.bgm.initialize();
    final tracks = _musicTracks[type];
    if (tracks != null && tracks.isNotEmpty) {
      final track = tracks[_random.nextInt(tracks.length)];
      await FlameAudio.bgm.play("music/$track");
    }
  }

  @override
  Future<void> stopMusic() async {
    await FlameAudio.bgm.stop();
  }

  @override
  Future<void> playSfx({required SfxType type}) async {
    if (_muted) return;

    final tracks = _sfxTracks[type];
    if (tracks != null && tracks.isNotEmpty) {
      final sfx = tracks[_random.nextInt(tracks.length)];
      await FlameAudio.play("sfx/$sfx");
    }
  }

  @override
  Future<void> muteAll() async {
    _muted = true;
    await FlameAudio.bgm.stop();
  }

  @override
  Future<void> unMuteAll() async {
    _muted = false;
    await playMusic();
  }
}
