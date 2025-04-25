import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/audio_repository.dart';
import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioRepository audioRepository;

  AudioBloc({required this.audioRepository}) : super(AudioState.initial()) {
    on<PlayMusic>((event, emit) async {
      await audioRepository.playMusic(type: event.type);
    });

    on<StopMusic>((event, emit) async {
      await audioRepository.stopMusic();
    });

    on<PlaySfx>((event, emit) async {
      await audioRepository.playSfx(type: event.type);
    });

    on<MuteAudio>((event, emit) async {
      await audioRepository.muteAll();
      emit(state.copyWith(isMuted: true));
    });

    on<UnMuteAudio>((event, emit) async {
      await audioRepository.unMuteAll();
      emit(state.copyWith(isMuted: false));
    });
  }
}
