import 'package:eatpencil/components/note_content.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';

class NoteCard extends ConsumerWidget {
  final Note note;
  final Misskey server;

  const NoteCard({
    super.key,
    required this.note,
    required this.server,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: theme(ref).panel,
          // 一番上と一番下に余計なBorderがつくので、
          // https://github.com/flutter/flutter/issues/48226
          // が実装され次第修正
          border: Border.symmetric(
            horizontal: BorderSide(
              color: theme(ref).divider,
              width: 0.5,
            ),
          )),
      child: Padding(
        padding: const EdgeInsets.all(12.5),
        child: NoteContent(
          note: note,
          server: server,
        ),
      ),
    );
  }
}
