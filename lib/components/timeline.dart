import 'package:eatpencil/components/loading_circle.dart';
import 'package:eatpencil/components/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:eatpencil/providers.dart';

class Timeline extends ConsumerStatefulWidget {
  const Timeline({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TimelineState();
  }
}

class TimelineState extends ConsumerState<Timeline> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Note> _notes = [];
  bool _isFetching = true;

  void cleanConnections(Misskey server) {
    server.streamingService.close();
  }

  void cleanNotes() {
    _notes.clear();
    _listKey.currentState?.removeAllItems((context, animation) => SizeTransition(
      sizeFactor: animation,
      child: const SizedBox(),
    ));
  }

  void initNotes(Misskey server) {
    setState(() {
      _isFetching = true;
    });
    server.notes.localTimeline(
      const NotesLocalTimelineRequest(limit: 50),
    ).then((initialNotes) {
      _notes.addAll(initialNotes);
      _listKey.currentState?.insertAllItems(
        _notes.length - initialNotes.length,
        initialNotes.length,
        duration: const Duration(milliseconds: 700),
      );
      setState(() {
        _isFetching = false;
      });
    });
  }

  void connectStream(Misskey server) {
    server.streamingService.startStreaming();
    server.localTimelineStream(
      parameter: const LocalTimelineParameter(),
      onNoteReceived: (Note newNote) {
        _notes.insert(0, newNote);
        _listKey.currentState?.insertItem(
          0,
          duration: const Duration(milliseconds: 700),
        );
      },
    );
  }

  @override
  void initState() {
    initNotes(ref.read(focusedServerProvider));
    connectStream(ref.read(focusedServerProvider));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(focusedServerProvider, (prevServer, server) {
      if (prevServer != null) cleanConnections(prevServer);
      cleanNotes();
      initNotes(server);
      connectStream(server);
    });

    return Column(
      children: [
        if (_isFetching) ...[
          const Gap(40),
          const LoadingCircle(),
          const Gap(40),
        ],
        Expanded(
          child: AnimatedList(
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
                  server: ref.read(focusedServerProvider),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
