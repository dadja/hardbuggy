import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hardbuggy/audio/domain/entities/sfx_type.dart';
import 'package:hardbuggy/habuggygame.dart';
import 'package:hardbuggy/menu/data/models/settings_model.dart';
import 'package:hardbuggy/menu/data/repositories/settings_repository_impl.dart';
import 'package:hardbuggy/menu/presentation/bloc/settings_bloc.dart';
import 'package:hardbuggy/menu/presentation/bloc/settings_event.dart';
import 'package:hardbuggy/menu/presentation/game_over_menu.dart';
import 'package:hardbuggy/menu/presentation/game_won_menu.dart';
import 'package:hardbuggy/menu/presentation/paused_menu.dart';
import 'package:hardbuggy/menu/presentation/settings_menu.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'audio/audio_controller.dart';
import 'audio/data/repositories/audio_repository_impl.dart';
import 'audio/presentation/bloc/audio_bloc.dart';
import 'menu/domain/entities/menu_type.dart';
import 'menu/presentation/bloc/settings_state.dart';
import 'menu/presentation/main_menu.dart';
import 'menu/presentation/widgets/space_button.dart';
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
    final audioController = AudioController(audioBloc);
    final game = HardBuggyGame(audioController);
    settingsBloc.add(LoadSettings());
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        MenuType.main.name: (context, game) =>
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) => MainMenu(
                onPlay: () {
                  if (!state.settings.isSoundMuted) {
                    audioController.playSfx(type: SfxType.menu);
                  }
                  (game as HardBuggyGame).overlays.remove(MenuType.main.name);
                  game.startGame();
                },
                onSettings: () {
                  if (!state.settings.isSoundMuted) {
                    audioController.playSfx(type: SfxType.menu);
                  }
                  (game as HardBuggyGame).overlays.remove(MenuType.main.name);
                  game.overlays.add(MenuType.gameSettings.name);
                },
              ),
            ),
        MenuType.pause.name: (_, __) => Positioned(
              top: 20,
              right: 20,
              child: SpaceButton(
                isIconOnly: true,
                onPressed: () {
                  audioController.playSfx(type: SfxType.menu);
                  game.pauseEngine();
                  game.overlays.add(MenuType.gamePaused.name);
                  game.onPause();
                  game.overlays.remove(MenuType.pause.name);
                },
                child: Icon(CupertinoIcons.pause_solid),
              ),
            ),
        MenuType.gameOver.name: (_, __) =>
            GameOverMenu(audioController: audioController, game: game),
        MenuType.gameWon.name: (_, __) => GameWonMenu(audioController: audioController, game: game),
        MenuType.gamePaused.name: (_, __) =>
            PausedMenu(audioController: audioController, game: game),
        MenuType.gameResumed.name: (_, __) => const Center(
            child: Text('Game Resumed',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gameStarted.name: (_, __) => const Center(
            child: Text('Game Started',
                style: TextStyle(color: Colors.white, fontSize: 40))),
        MenuType.gameSettings.name: (_, __) =>
            SettingsMenu(audioController: audioController, game: game),
        // optional: add back button
      },
    );
  }
}
