import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatpencil/components/note.dart';
import 'package:misskey_dart/misskey_dart.dart';

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
          _listKey.currentState
              ?.insertItem(0, duration: const Duration(milliseconds: 700));
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
          sizeFactor: CurveTween(
            curve: const Cubic(0.23, 1, 0.32, 1),
          ).animate(animation),
          child: NoteCard(
            note: _notes[index],
          ),
        );
      },
    );
  }
}
