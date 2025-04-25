import 'presentation/bloc/audio_bloc.dart';
import 'presentation/bloc/audio_event.dart';

class AudioController {
  final AudioBloc bloc;

  AudioController(this.bloc);

  void playBgm() => bloc.add(PlayBgm());

  void stopBgm() => bloc.add(StopBgm());

  void playSfx(String file) => bloc.add(PlaySfx(file));

  void mute() => bloc.add(MuteAudio());

  void unMute() => bloc.add(UnMuteAudio());
}
