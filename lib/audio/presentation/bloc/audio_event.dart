import 'package:equatable/equatable.dart';
import 'package:hardbuggy/audio/domain/entities/music_type.dart';
import 'package:hardbuggy/audio/domain/entities/sfx_type.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class PlayMusic extends AudioEvent {
  final MusicType type;
  const PlayMusic(this.type);

  @override
  List<Object> get props => [type];
}

class StopMusic extends AudioEvent {}

class PlaySfx extends AudioEvent {
  final SfxType type;
  const PlaySfx(this.type);

  @override
  List<Object> get props => [type];
}

class MuteAudio extends AudioEvent {}

class UnMuteAudio extends AudioEvent {}
