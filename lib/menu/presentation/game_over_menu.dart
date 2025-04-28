import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hardbuggy/audio/audio_controller.dart';
import 'package:hardbuggy/audio/domain/entities/sfx_type.dart';
import 'package:hardbuggy/habuggygame.dart';
import 'package:hardbuggy/menu/domain/entities/menu_type.dart';
import 'package:hardbuggy/theme/pallet_color.dart';

import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';
import 'widgets/space_button.dart';
import 'widgets/space_text_button.dart';

class GameOverMenu extends StatefulWidget {
  final AudioController audioController;
  final HardBuggyGame game;

  const GameOverMenu(
      {super.key, required this.audioController, required this.game});

  @override
  State<GameOverMenu> createState() => _GameOverMenuState();
}

class _GameOverMenuState extends State<GameOverMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          color: Colors.redAccent,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            color: Colors.black.withValues(alpha: 0.8),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              PalletColor.primaryColor,
                              PalletColor.secondaryColor
                            ],
                          ).createShader(bounds),
                          child: Text(
                            'Game Over',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Theme.of(context).shadowColor,
                                  offset: Offset(2, 5),
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SpaceButton(
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () {
                            if (!state.settings.isSoundMuted) {
                              widget.audioController
                                  .playSfx(type: SfxType.menu);
                            }
                            widget.game.overlays
                                .remove(MenuType.gameOver.name);
                            widget.game.startGame();
                          },
                          child: SpaceTextButton(text: 'Retry'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
