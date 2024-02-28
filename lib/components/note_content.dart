import 'package:eatpencil/components/bottom_sheet_menu.dart';
import 'package:eatpencil/components/general/simple_icon_button.dart';
import 'package:eatpencil/components/general/space.dart';
import 'package:eatpencil/components/reactions_viewer.dart';
import 'package:eatpencil/components/general/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:mfm/mfm.dart';
import '../providers.dart';

class NoteContent extends ConsumerWidget {
  final Note note;
  final Misskey server;
  final int? depth;

  const NoteContent({
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

    return isPureRenote
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    TablerIcons.repeat,
                    color: theme(ref).renote,
                    size: 15,
                  ),
                  const Space(width: 5),
                  Expanded(
                    child: Text(
                      "${note.user.name}がリノート",
                      style: TextStyle(
                        color: theme(ref).renote,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
              const Space(height: 10),
              NoteContent(
                note: note.renote!,
                server: server,
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.user.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SelectionArea(
                child: Mfm(
                  mfmText: note.text ?? "",
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 16 / 9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (final file in imageFiles)
                    Image.network(
                      file.thumbnailUrl ?? file.url,
                    ),
                  for (final file in videoFiles)
                    VideoPlayer(
                      url: file.url,
                    ),
                ],
              ),
              if (isQuote && (depth ?? 0) < 4)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme(ref).renote,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: NoteContent(
                    note: note.renote!,
                    server: server,
                    depth: (depth ?? 0) + 1,
                  ),
                ),
              if ((depth ?? 0) < 1)
                ReactionsViewer(
                  note: note,
                  onReactionTap: (reaction) {
                    server.notes.reactions.create(
                      NotesReactionsCreateRequest(
                        noteId: note.id,
                        reaction: reaction,
                      ),
                    );
                  },
                ),
              if ((depth ?? 0) < 1)
                Row(
                  children: [
                    SimpleIconButton(
                      icon: const Icon(TablerIcons.arrow_back_up),
                      onPressed: () {
                        // TODO: Reply
                      },
                    ),
                    const Space(width: 20),
                    SimpleIconButton(
                      icon: const Icon(TablerIcons.repeat),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BottomSheetMenu(
                              entries: [
                                Entry(
                                  title: "リノート",
                                  icon: TablerIcons.repeat,
                                  onPressed: () {
                                    server.notes.create(
                                      NotesCreateRequest(
                                        renoteId: note.id,
                                      ),
                                    );
                                  },
                                ),
                                Entry(
                                  title: "引用リノート",
                                  icon: TablerIcons.quote,
                                  onPressed: () {
                                    // TODO: Quote
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Space(width: 20),
                    SimpleIconButton(
                      icon: const Icon(TablerIcons.plus),
                      onPressed: () {
                        // TODO: Reaction
                      },
                    ),
                    const Space(width: 20),
                    SimpleIconButton(
                      icon: const Icon(TablerIcons.dots),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BottomSheetMenu(
                              entries: [
                                Entry(
                                  title: "詳細",
                                  icon: TablerIcons.info_circle,
                                  onPressed: () {
                                    // TODO: Detail
                                  },
                                ),
                                Entry(
                                  title: "内容をコピー",
                                  icon: TablerIcons.copy,
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: note.text ?? ""),
                                    );
                                  },
                                ),
                                Entry(
                                  title: "リンクをコピー",
                                  icon: TablerIcons.link,
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: "https://${server.host}/notes/${note.id}"),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
            ],
          );
  }
}