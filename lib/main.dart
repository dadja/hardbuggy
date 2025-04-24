import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hardbuggy/habuggygame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  HardBuggyGame game = HardBuggyGame();
  runApp(
    GameWidget(game: kDebugMode ? HardBuggyGame() : game, overlayBuilderMap: {
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
    }),
  );
}
