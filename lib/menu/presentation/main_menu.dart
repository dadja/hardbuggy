import 'package:flutter/material.dart';
import 'package:hardbuggy/theme/pallet_color.dart';

import 'widgets/space_background.dart';
import 'widgets/space_button.dart';
import 'widgets/space_text_button.dart';

class MainMenu extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onSettings;

  const MainMenu({
    super.key,
    required this.onPlay,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        const SpaceBackground(),
        Container(
          color: Colors.black.withValues(alpha: 0.8),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.rotate(
                    angle: -0.1,
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          PalletColor.primaryColor,
                          PalletColor.secondaryColor
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'HardBuggy',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.8),
                            shadows: [
                              Shadow(
                                color: Theme.of(context).shadowColor,
                                offset: Offset(2, 5),
                                blurRadius: 20.0,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SpaceButton(
                    onPressed: onPlay,
                    withAnimation: true,
                    child: SpaceTextButton(text: 'Play'),
                  ),
                  const SizedBox(height: 20),
                  SpaceButton(
                    onPressed: onSettings,
                    child: SpaceTextButton(text: 'Settings'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
