import 'package:flutter/material.dart';

class IconWithBackground extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;

  const IconWithBackground({
    super.key,
    required this.icon,
    this.size = 22,
    this.backgroundColor = Colors.grey,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: backgroundColor,
        child: Icon(
          icon,
          size: size * 0.6,
          color: foregroundColor,
        ),
      ),
    );
  }
}
