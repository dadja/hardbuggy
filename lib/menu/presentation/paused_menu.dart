import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hardbuggy/audio/audio_controller.dart';
import 'package:hardbuggy/audio/domain/entities/sfx_type.dart';
import 'package:hardbuggy/habuggygame.dart';
import 'package:hardbuggy/menu/domain/entities/menu_type.dart';
import 'package:hardbuggy/menu/presentation/widgets/space_background.dart';
import 'package:hardbuggy/menu/presentation/widgets/space_button.dart';
import 'package:hardbuggy/theme/pallet_color.dart';

import 'bloc/settings_bloc.dart';
import 'bloc/settings_state.dart';
import 'widgets/space_text_button.dart';

class PausedMenu extends StatefulWidget {
  final AudioController audioController;
  final HardBuggyGame game;

  const PausedMenu(
      {super.key, required this.audioController, required this.game});

  @override
  State<PausedMenu> createState() => _PausedMenuState();
}

class _PausedMenuState extends State<PausedMenu> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const SpaceBackground(),
          Container(
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
                            'Paused',
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
                            widget.game.resumeEngine();
                            widget.game.onResume();
                            widget.game.overlays.remove(MenuType.gamePaused.name);
                            widget.game.overlays.add(MenuType.pause.name);
                          },
                          child: SpaceTextButton(text: 'Resume'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
