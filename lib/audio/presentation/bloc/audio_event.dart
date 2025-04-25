import 'package:equatable/equatable.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class PlayBgm extends AudioEvent {}

class StopBgm extends AudioEvent {}

class PlaySfx extends AudioEvent {
  final String fileName;

  const PlaySfx(this.fileName);

  @override
  List<Object> get props => [fileName];
}

class MuteAudio extends AudioEvent {}

class UnMuteAudio extends AudioEvent {}
