import 'package:flutter/material.dart';
import 'package:hardbuggy/theme/pallet_color.dart';

class SpaceToggleSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SpaceToggleSwitch(
      {super.key,
      required this.title,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 400, // Limit max width to avoid overflow
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: PalletColor.primaryColor.withValues(alpha: 0.7),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: PalletColor.primaryColor.withValues(alpha: 0.6),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    color: Colors.cyanAccent,
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          Switch(
            activeColor: Colors.cyanAccent,
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withValues(alpha: 0.5),
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
