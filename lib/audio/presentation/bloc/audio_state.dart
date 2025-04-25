import 'package:equatable/equatable.dart';

class AudioState extends Equatable {
  final bool isMuted;

  const AudioState({required this.isMuted});

  factory AudioState.initial() => const AudioState(isMuted: false);

  AudioState copyWith({bool? isMuted}) {
    return AudioState(isMuted: isMuted ?? this.isMuted);
  }

  @override
  List<Object> get props => [isMuted];
}
