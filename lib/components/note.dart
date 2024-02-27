import 'package:eatpencil/components/bottom_sheet_menu.dart';
import 'package:eatpencil/components/general/simple_icon_button.dart';
import 'package:eatpencil/components/general/space.dart';
import 'package:eatpencil/components/note_content.dart';
import 'package:eatpencil/components/reactions_viewer.dart';
import 'package:eatpencil/components/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:mfm/mfm.dart';
import '../providers.dart';

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
    final isRenote = note.renote != null;
    final isQuote = isRenote && (note.text != null || note.cw != null || note.files.isNotEmpty || note.poll != null);
    final isPureRenote = isRenote && !isQuote;
    final isReply = note.reply != null;

    final imageFiles = note.files.where((file) => file.type.contains("image"));
    final videoFiles = note.files.where((file) => file.type.contains("video"));
    final audioFiles = note.files.where((file) => file.type.contains("audio"));
    final otherFiles = note.files.where(
      (file) => !imageFiles.contains(file) && !videoFiles.contains(file) && !audioFiles.contains(file),
    );

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
