import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/audio_repository.dart';
import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioRepository audioRepository;

  AudioBloc({required this.audioRepository}) : super(AudioState.initial()) {
    on<PlayBgm>((event, emit) async {
      await audioRepository.playBackgroundMusic();
    });

    on<StopBgm>((event, emit) async {
      await audioRepository.stopBackgroundMusic();
    });

    on<PlaySfx>((event, emit) async {
      await audioRepository.playSfx(event.fileName);
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
