import 'domain/entities/music_type.dart';
import 'domain/entities/sfx_type.dart';
import 'presentation/bloc/audio_bloc.dart';
import 'presentation/bloc/audio_event.dart';

class AudioController {
  final AudioBloc bloc;

  AudioController(this.bloc);

  void playMusic({MusicType type=MusicType.game}) => bloc.add(PlayMusic(type));

  void stopMusic() => bloc.add(StopMusic());

  void playSfx({required SfxType type}) => bloc.add(PlaySfx(type));

  void mute() => bloc.add(MuteAudio());

  void unMute() => bloc.add(UnMuteAudio());
}
