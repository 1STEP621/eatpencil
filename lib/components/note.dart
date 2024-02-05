import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:mfm/mfm.dart';

class NoteCard extends ConsumerWidget {
  final Note note;

  const NoteCard({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.user.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Mfm(mfmText: note.text ?? ""),
          ],
        ),
      ),
    );
  }
}
