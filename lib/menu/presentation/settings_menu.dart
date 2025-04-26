import 'package:flutter/material.dart';
import 'package:hardbuggy/audio/audio_controller.dart';

class SettingsMenu extends StatelessWidget {
  final AudioController audioController;

  const SettingsMenu({super.key, required this.audioController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed:(){},
            child: const Text('Mute'),
          ),
        ],
      ),
    );
  }
}
