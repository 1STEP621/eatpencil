import 'package:eatpencil/components/general/custom_cached_network_image.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomEmoji extends ConsumerWidget {
  final String shortcode;
  final String? serverUrl;
  final Map<String, String> additionalEmojis;
  final double height;

  const CustomEmoji({
    super.key,
    required this.shortcode,
    this.serverUrl = ".",
    this.additionalEmojis = const {},
    this.height = 22,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiUrl = (serverUrl ?? ".") == "."
        ? (ref.watch(emojisMapProvider).value?[shortcode]?.url.toString())
        : additionalEmojis["$shortcode@$serverUrl"];

    return emojiUrl == null
        ? Image.asset(
            "assets/images/dummy.png",
            height: height,
          )
        : CustomCachedNetworkImage(
            imageUrl: emojiUrl.toString(),
            height: height,
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/dummy.png",
              height: height,
            ),
          );
  }
}
