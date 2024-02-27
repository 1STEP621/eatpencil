import 'package:eatpencil/components/note_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';

class NoteCard extends ConsumerWidget {
  final Note note;
  final Misskey server;
  final int? depth;

  const NoteCard({
    super.key,
    required this.note,
    required this.server,
    this.depth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: NoteContent(
          note: note,
          server: server,
          depth: depth,
        ),
      ),
    );
  }
}
