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
  SocketController? _stream;
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
    server.notes
        .hybridTimeline(
      const NotesHybridTimelineRequest(limit: 50),
    )
        .then((initialNotes) {
      _controller.addAll(initialNotes.toList());
      for (final note in _controller.contents()) {
        _stream?.subNote(note.id);
      }
      setState(() {
        _isFetching = false;
      });
    });
  }

  void connectStream(Misskey server) {
    server.streamingService.startStreaming();
    _stream = server.hybridTimelineStream(
      parameter: const HybridTimelineParameter(),
      onNoteReceived: (newNote) {
        _controller.addAll([newNote]);
        _stream?.subNote(newNote.id);
      },
      onReacted: (id, reaction) {
        final note = _controller.contents().firstWhere((note) => note.id == id);
        Map<String, int> reactions = {...note.reactions};
        reactions.update(reaction.reaction, (count) => count + 1, ifAbsent: () => 1);
        Map<String, String> reactionEmojis = {...note.reactionEmojis};
        if (reaction.emoji != null) {
          reactionEmojis[reaction.emoji!.name] = reaction.emoji!.url;
        }
        String? myReaction = note.myReaction;
        if (reaction.userId == ref.watch(iProvider).value?.id) {
          myReaction = reaction.reaction;
        }
        _controller.update(
          note,
          note.copyWith(
            reactions: reactions,
            reactionEmojis: reactionEmojis,
            myReaction: myReaction,
          ),
        );
      },
      onUnreacted: (id, reaction) {
        final note = _controller.contents().firstWhere((note) => note.id == id);
        Map<String, int> reactions = {...note.reactions};
        reactions.update(reaction.reaction, (count) => count - 1, ifAbsent: () => 0);
        reactions.removeWhere((_, count) => count == 0);
        Map<String, String> reactionEmojis = {...note.reactionEmojis};
        if (reactions[reaction.reaction] == 0) {
          reactions.remove(reaction.reaction);
          reactionEmojis.remove(reaction.emoji!.name);
        }
        String? myReaction = note.myReaction;
        if (reaction.userId == ref.watch(iProvider).value?.id) {
          myReaction = null;
        }
        _controller.update(
          note,
          note.copyWith(
            reactions: reactions,
            reactionEmojis: reactionEmojis,
            myReaction: myReaction,
          ),
        );
      },
      onDeleted: (id, _) {
        final note = _controller.contents().firstWhere((note) => note.id == id);
        _controller.remove(note);
        _stream?.unsubNote(note.id);
      },
    );
  }

  @override
  void initState() {
    connectStream(ref.read(focusedServerProvider));
    initNotes(ref.read(focusedServerProvider));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(focusedServerProvider, (prevServer, server) {
      if (prevServer != null) cleanConnections(prevServer);
      cleanNotes();
      connectStream(server);
      initNotes(server);
    });

    return RefreshIndicator(
      onRefresh: () async {
        cleanConnections(ref.read(focusedServerProvider));
        cleanNotes();
        connectStream(ref.read(focusedServerProvider));
        initNotes(ref.read(focusedServerProvider));
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
                  server: ref.read(focusedServerProvider),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
