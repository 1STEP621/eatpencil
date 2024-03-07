import 'package:eatpencil/components/general/animated_list_with_controller.dart';
import 'package:eatpencil/components/general/loading_circle.dart';
import 'package:eatpencil/components/note.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:misskey_dart/misskey_dart.dart';

class Timeline extends ConsumerStatefulWidget {
  const Timeline({super.key});

  @override
  ConsumerState<Timeline> createState() => _TimelineState();
}

class _TimelineState extends ConsumerState<Timeline> {
  final _controller = AnimatedListController<Note>();
  bool _isFetching = false;

  void cleanConnections(Misskey server) {
    server.streamingService.close();
  }

  void cleanNotes() {
    _controller.clear();
  }

  void initNotes(Misskey server) {
    setState(() {
      _isFetching = true;
    });
    server.notes.localTimeline(
      const NotesLocalTimelineRequest(limit: 50),
    ).then((initialNotes) {
      _controller.addAll(initialNotes.toList());
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
        _controller.addAll([newNote]);
      },
    );
  }

  @override
  void initState() {
    initNotes(ref.read(focusedServerProvider)!);
    connectStream(ref.read(focusedServerProvider)!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(focusedServerProvider, (prevServer, server) {
      if (prevServer != null) cleanConnections(prevServer);
      cleanNotes();
      initNotes(server!);
      connectStream(server);
    });

    return RefreshIndicator(
      onRefresh: () async {
        cleanConnections(ref.read(focusedServerProvider)!);
        cleanNotes();
        initNotes(ref.read(focusedServerProvider)!);
        connectStream(ref.read(focusedServerProvider)!);
      },
      child: Column(
        children: [
          if (_isFetching) ...[
            const Gap(40),
            const LoadingCircle(),
            const Gap(40),
          ],
          Expanded(
            child: AnimatedListWithController<Note>(
              controller: _controller,
              itemBuilder: (context, note, animation) {
                return NoteCard(
                  note: note,
                  server: ref.read(focusedServerProvider)!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
