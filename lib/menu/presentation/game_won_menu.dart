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

class GameWonMenu extends StatefulWidget {
  final AudioController audioController;
  final HardBuggyGame game;

  const GameWonMenu(
      {super.key, required this.audioController, required this.game});

  @override
  State<GameWonMenu> createState() => _GameWonMenuState();
}

class _GameWonMenuState extends State<GameWonMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
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
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          color: Colors.greenAccent.shade400,
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
                            (widget.game.currentLevelIndex < widget.game.levelNames.length) ? 'Level ${widget.game.currentLevelIndex} Complete' : 'You reached the end of the game thanks for playing ',
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
                        Visibility(
                          visible:(widget.game.currentLevelIndex < widget.game.levelNames.length) ,
                          child:SpaceButton(
                            color: Colors.greenAccent.shade400,
                            onPressed: () {
                              if (!state.settings.isSoundMuted) {
                                widget.audioController
                                    .playSfx(type: SfxType.menu);
                              }
                              widget.game.overlays.remove(MenuType.gameWon.name);
                              if(widget.game.currentLevelIndex < widget.game.levelNames.length){
                                widget.game.currentLevelIndex++;
                                print("The currentLevel = ${widget.game.currentLevelIndex} ");
                                widget.game.startGame();

                              }

                            },
                            child: SpaceTextButton(text: 'Go to next level'),
                          ),
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
