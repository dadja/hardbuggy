import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hardbuggy/habuggygame.dart';
import 'package:hardbuggy/menu/presentation/settings_menu.dart';

import 'audio/audio_controller.dart';
import 'audio/data/audio_repository_impl.dart';
import 'audio/presentation/bloc/audio_bloc.dart';
import 'menu/domain/entities/menu_type.dart';
import 'menu/presentation/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  final audioRepository = AudioRepositoryImpl();

  runApp(
    MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.bungeeInlineTextTheme(),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AudioBloc>(
            create: (_) => AudioBloc(audioRepository: audioRepository),
          ),
        ],
        child: GameWrapper(),
      ),
    ),
  );
}

class GameWrapper extends StatelessWidget {
  const GameWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AudioBloc>(context);
    final controller = AudioController(bloc);
    return GameWidget(
      game: HardBuggyGame(controller),
      overlayBuilderMap: {
        MenuType.main.name: (context, game) => MainMenu(
              onPlay: () {
                (game as HardBuggyGame).overlays.remove(MenuType.main.name);
                game.startGame();
              },
              onSettings: () {
                (game as HardBuggyGame).overlays.remove(MenuType.main.name);
                game.overlays.add(MenuType.gameSettings.name);
              },
            ),
        MenuType.pause.name: (_, __) => const Center(
            child: Text('Pause',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gameOver.name: (_, __) => const Center(
            child: Text('Game Over',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gameWon.name: (_, __) => const Center(
            child: Text('You Won',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gamePaused.name: (_, __) => const Center(
            child: Text('Game Paused',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gameResumed.name: (_, __) => const Center(
            child: Text('Game Resumed',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gameStarted.name: (_, __) => const Center(
            child: Text('Game Started',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gameSettings.name: (_, __) =>
            SettingsMenu(audioController: controller),
        // optional: add back button
      },
    );
  }
}
