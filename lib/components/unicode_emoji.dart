import 'package:flutter/material.dart';
import 'package:twemoji/twemoji.dart';

class UnicodeEmoji extends StatelessWidget {
  final String emoji;
  final double size;

  const UnicodeEmoji({super.key, required this.emoji, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return Twemoji(
      emoji: emoji,
      height: size,
    );
  }
}
