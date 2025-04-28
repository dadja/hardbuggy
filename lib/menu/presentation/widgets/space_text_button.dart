import 'package:flutter/material.dart';

class SpaceTextButton extends StatelessWidget {
  final String text;

  const SpaceTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.8),
          ),
    );
  }
}
