import 'package:eatpencil/components/general/row_with_gap.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:eatpencil/components/emoji.dart';

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
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: note.myReaction == reaction.key ? theme(ref).accentedBg : theme(ref).buttonBg,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: note.myReaction == reaction.key
                    ? Border.all(
                        color: theme(ref).accent,
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignInside,
                      )
                    : null,
              ),
              child: RowWithGap(
                gap: 5,
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmojiImage(
                    emoji: reaction.key,
                    additionalEmojis: note.reactionEmojis,
                    size: 18,
                  ),
                  Text(
                    reaction.value.toString(),
                    style: TextStyle(
                      color: note.myReaction == reaction.key ? theme(ref).accent : theme(ref).fg,
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
