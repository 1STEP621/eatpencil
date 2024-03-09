import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatpencil/providers.dart';
import 'package:eatpencil/components/general/custom_cached_network_image.dart';

class NoteEmojiImage extends ConsumerWidget {
  final String emojiName;
  final Map<String, String>? overrideEmojis;
  final TextStyle? style;
  final double emojiMultiplier;

  const NoteEmojiImage({super.key, required this.emojiName, this.overrideEmojis, this.style, this.emojiMultiplier = 2});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiUrl = (overrideEmojis ?? {}).isEmpty
        ? (ref.watch(emojisMapProvider).value?[emojiName]?.url.toString())
        : overrideEmojis![emojiName];

    return emojiUrl == null
        ? Text(emojiName, style: style)
        : CustomCachedNetworkImage(
            imageUrl: emojiUrl.toString(),
            height: (style?.fontSize ?? kDefaultFontSize) * emojiMultiplier,
          );
  }
}
