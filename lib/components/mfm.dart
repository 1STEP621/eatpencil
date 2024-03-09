import 'package:eatpencil/components/general/custom_cached_network_image.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mfm/mfm.dart';
import 'package:twemoji/twemoji.dart';

class NormalMfm extends ConsumerWidget {
  final String text;
  final Map<String, String>? overrideEmojis;

  const NormalMfm(this.text, {super.key, this.overrideEmojis});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Mfm(
      mfmText: text,
      style: const TextStyle(fontSize: kDefaultFontSize),
      emojiBuilder: (context, emojiName, style) {
        final emojiUrl = overrideEmojis == null
            ? overrideEmojis![emojiName]
            : ref.watch(emojisMapProvider).value?[emojiName]?.url.toString();

        return emojiUrl == null
            ? Text(emojiName, style: style)
            : CustomCachedNetworkImage(
                imageUrl: emojiUrl.toString(),
                height: (style?.fontSize ?? kDefaultFontSize) * 2,
              );
      },
      unicodeEmojiBuilder: (context, emoji, style) {
        return TwemojiTextSpan(
          text: emoji,
          twemojiFormat: TwemojiFormat.svg,
          emojiFontMultiplier: 1.3,
          style: style,
        );
      },
      codeBlockBuilder: (context, code, lang) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          clipBehavior: Clip.hardEdge,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: HighlightView(
              code,
              language: lang,
              theme: atomOneDarkTheme,
              padding: const EdgeInsets.all(10),
            ),
          ),
        );
      },
      defaultBorderColor: theme(ref).accent,
      hashtagStyle: TextStyle(
        color: theme(ref).hashtag,
        fontWeight: FontWeight.bold,
      ),
      inlineCodeBuilder: (context, text, style) {
        return Text(
          text,
          style: style,
        );
      },
      smallStyleBuilder: (context, fontSize) {
        return TextStyle(
          fontSize: fontSize,
          color: theme(ref).fgTransparent,
        );
      },
    );
  }
}
