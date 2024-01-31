import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mfm/mfm.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:eatpencil/providers.dart';

class Timeline extends ConsumerStatefulWidget {
  final Misskey server;

  const Timeline({required this.server, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TimelineState();
  }
}

class TimelineState extends ConsumerState<Timeline> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Note> _notes = [];

  @override
  void initState() {
    widget.server.streamingService.startStreaming();
    widget.server.hybridTimelineStream(
      parameter: const HybridTimelineParameter(),
      onNoteReceived: (Note newNote) {
        setState(() {
          _notes.insert(0, newNote);
          _listKey.currentState?.insertItem(0);
          if (_notes.length > 50) {
            _notes.removeLast();
          }
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _notes.length,
      itemBuilder: (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) {
        return SizeTransition(
          sizeFactor: animation,
          child: NoteCard(
            note: _notes[index],
          ),
        );
      },
    );
  }
}

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
            Mfm(mfmText: note?.text ?? ""),
          ],
        ),
      ),
    );
  }
}
