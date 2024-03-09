import 'package:eatpencil/components/general/custom_cached_network_image.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmojiImage extends ConsumerWidget {
  final String shortcode;
  final String? serverUrl;
  final Map<String, String> additionalEmojis;
  final double height;

  const EmojiImage({super.key, required this.shortcode, this.serverUrl = ".", this.additionalEmojis = const {}, this.height = 22});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiUrl = (serverUrl ?? ".") == "."
        ? (ref.watch(emojisMapProvider).value?[shortcode]?.url.toString())
        : additionalEmojis["$shortcode@$serverUrl"];

    if (emojiUrl != null) {
      return CustomCachedNetworkImage(
        imageUrl: emojiUrl.toString(),
        height: height,
      );
    } else {
      return Text(shortcode);
    }
  }
}
