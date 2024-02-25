import 'package:flutter/material.dart';
import 'package:misskey_dart/misskey_dart.dart';

class ReactionsViewer extends StatelessWidget {
  final Note note;
  final void Function(String) onReactionTap;

  const ReactionsViewer({
    super.key,
    required this.note,
    required this.onReactionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final reaction in note.reactions.entries)
          GestureDetector(
            onTap: () {
              onReactionTap(reaction.key);
            },
            child: Text(
              reaction.key,
            ),
          )
      ],
    );
  }
}
