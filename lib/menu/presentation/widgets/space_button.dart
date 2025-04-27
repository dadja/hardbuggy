import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hardbuggy/theme/pallet_color.dart';

class SpaceButton extends StatefulWidget {
  final String text;
  final Color color;
  final bool withAnimation;
  final VoidCallback onPressed;

  const SpaceButton(
      {required this.text,
      this.color = PalletColor.secondaryColor,
      this.withAnimation = false,
      required this.onPressed,
      super.key});

  @override
  State<SpaceButton> createState() => _SpaceButtonState();
}

class _SpaceButtonState extends State<SpaceButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: widget.color,
          width: 2,
        ),
        shadowColor: widget.color.withValues(alpha: 0.6),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fixedSize: Size(width/3, 60),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: widget.onPressed,
      child: widget.withAnimation
          ? AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => _buttonData(),
            )
          : _buttonData(),
    );
  }

  Widget _buttonData() {
    return widget.withAnimation
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Icon moving left to right
              Transform.translate(
                offset: Offset(_animation.value, 0),
                child: Icon(
                  CupertinoIcons.play_arrow_solid,
                  color: Colors.white.withValues(alpha: 0.6),
                  shadows: [
                    BoxShadow(
                      color: widget.color,
                      offset: Offset(2, 4),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
              ),
              Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
              ),
              // Right Icon moving right to left
              Transform.translate(
                offset: Offset(-_animation.value, 0),
                child: Transform.rotate(
                  angle: -1,
                  child: Icon(
                    CupertinoIcons.play_arrow_solid,
                    color: Colors.white.withValues(alpha: 0.6),
                    shadows: [
                      BoxShadow(
                        color: widget.color,
                        offset: Offset(-4, 0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
            ),
          );
  }
}
