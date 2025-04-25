import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hardbuggy/habuggygame.dart';

import 'audio/audio_controller.dart';
import 'audio/data/audio_repository_impl.dart';
import 'audio/presentation/bloc/audio_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  final audioRepository = AudioRepositoryImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AudioBloc>(
          create: (_) => AudioBloc(audioRepository: audioRepository),
        ),
      ],
      child: GameWrapper(),
    ),
  );
}

class GameWrapper extends StatelessWidget {
  const GameWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AudioBloc>(context);
    final controller = AudioController(bloc);
    return GameWidget(game: HardBuggyGame(controller), overlayBuilderMap: {
      'pause': (context, game) {
        return const Center(
          child: Text(
            'Pause',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        );
      },
      'gameOver': (context, game) {
        return const Center(
          child: Text(
            'Game Over',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        );
      },
      'gameWon': (context, game) {
        return const Center(
          child: Text(
            'You Won',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        );
      },
      'gamePaused': (context, game) {
        return const Center(
          child: Text(
            'Game Paused',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        );
      },
      'gameResumed': (context, game) {
        return const Center(
          child: Text(
            'Game Resumed',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        );
      },
      'gameStarted': (context, game) {
        return const Center(
          child: Text(
            'Game Started',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
        );
      },
    });
  }
}
