import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Widget leading;
  final bool isVisible;
  final Duration duration;

  const AnimatedAppBar({
    Key? key, 
    required this.backgroundColor,
    required this.leading,
    required this.isVisible, 
    required this.duration,
  }) : super(key: key);

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AnimatedAppBarState extends State<AnimatedAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      leading: widget.leading,
    )
    .animate(target: widget.isVisible ? 1 : 0)
    .slideY(duration: Duration(milliseconds: widget.duration.inMilliseconds - 100))
    .fade(duration: widget.duration);
  }
}
