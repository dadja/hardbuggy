import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpaceButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const SpaceButton({required this.text, required this.onPressed, super.key});

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
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: width / 3,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF044569), Color(0xFFc774b2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.purpleAccent,
              offset: Offset(2, 5),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Icon moving left to right
                Transform.translate(
                  offset: Offset(_animation.value, 0),
                  child: Icon(
                    CupertinoIcons.play_arrow_solid,
                    color: Colors.white.withValues(alpha: 0.6),
                    shadows: const [
                      BoxShadow(
                        color: Colors.purpleAccent,
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
                      shadows: const [
                        BoxShadow(
                          color: Colors.purpleAccent,
                          offset: Offset(-4, 0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double cut = 20;
    path.moveTo(cut, 0);
    path.lineTo(size.width - cut, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
