import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hardbuggy/core/habuggygame.dart';

void main() {
  var game = HardBuggyGame();
  runApp(
    GameWidget(game: game, overlayBuilderMap: {
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
