import 'package:eatpencil/components/custom_emoji.dart';
import 'package:eatpencil/components/unicode_emoji.dart';
import 'package:eatpencil/utils/get_part_from_reaction.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmojiImage extends ConsumerWidget {
  final String emoji;
  final double size;
  final Map<String, String>? additionalEmojis;

  const EmojiImage({super.key, required this.emoji, this.size = 22, this.additionalEmojis = const {}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return emoji.contains(":")
        ? CustomEmoji(
            shortcode: getShortcode(emoji),
            serverUrl: getServerUrl(emoji),
            additionalEmojis: additionalEmojis ?? {},
            height: size,
          )
        : UnicodeEmoji(
            emoji: emoji,
            size: size,
          );
  }
}
