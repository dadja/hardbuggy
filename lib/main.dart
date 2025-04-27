import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hardbuggy/audio/domain/entities/sfx_type.dart';
import 'package:hardbuggy/habuggygame.dart';
import 'package:hardbuggy/menu/data/models/settings_model.dart';
import 'package:hardbuggy/menu/data/repositories/settings_repository_impl.dart';
import 'package:hardbuggy/menu/presentation/bloc/settings_bloc.dart';
import 'package:hardbuggy/menu/presentation/bloc/settings_event.dart';
import 'package:hardbuggy/menu/presentation/settings_menu.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'audio/audio_controller.dart';
import 'audio/data/repositories/audio_repository_impl.dart';
import 'audio/presentation/bloc/audio_bloc.dart';
import 'menu/domain/entities/menu_type.dart';
import 'menu/presentation/bloc/settings_state.dart';
import 'menu/presentation/main_menu.dart';
import 'theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  Hive.registerAdapter(SettingsModelAdapter());

  final audioRepository = AudioRepositoryImpl();
  final Box<SettingsModel> settingsBox = await Hive.openBox('user_settings');
  final settingsRepository = SettingsRepositoryImpl(settingsBox);

  runApp(
    MaterialApp(
      theme: spaceGameTheme,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AudioBloc>(
            create: (_) => AudioBloc(audioRepository: audioRepository),
          ),
          BlocProvider(
            create: (_) => SettingsBloc(repository: settingsRepository),
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
    final audioBloc = BlocProvider.of<AudioBloc>(context);
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    final controller = AudioController(audioBloc);
    final game = HardBuggyGame(controller);
    settingsBloc.add(LoadSettings());
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        MenuType.main.name: (context, game) =>
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) => MainMenu(
                onPlay: () {
                  if (!state.settings.isSoundMuted) {
                    controller.playSfx(type: SfxType.menu);
                  }
                  (game as HardBuggyGame).overlays.remove(MenuType.main.name);
                  game.startGame();
                },
                onSettings: () {
                  if (!state.settings.isSoundMuted) {
                    controller.playSfx(type: SfxType.menu);
                  }
                  (game as HardBuggyGame).overlays.remove(MenuType.main.name);
                  game.overlays.add(MenuType.gameSettings.name);
                },
              ),
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
            SettingsMenu(audioController: controller, game: game),
        // optional: add back button
      },
    );
  }
}
