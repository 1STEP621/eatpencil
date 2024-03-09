import 'package:eatpencil/components/emoji.dart';
import 'package:eatpencil/components/general/row_with_gap.dart';
import 'package:eatpencil/providers.dart';
import 'package:eatpencil/utils/get_part_from_reaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';

class ReactionsViewer extends ConsumerWidget {
  final Note note;
  final void Function(String) onReactionTap;

  const ReactionsViewer({
    super.key,
    required this.note,
    required this.onReactionTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        for (final reaction in note.reactions.entries)
          GestureDetector(
            onTap: () {
              onReactionTap(reaction.key);
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: theme(ref).buttonBg,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: RowWithGap(
                gap: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmojiImage(
                    shortcode: getShortcode(reaction.key),
                    serverUrl: getServerUrl(reaction.key),
                    additionalEmojis: note.reactionEmojis,
                  ),
                  Text(reaction.value.toString()),
                ],
              ),
            ),
          )
      ],
    );
  }
}
