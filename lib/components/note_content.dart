import 'package:dotted_border/dotted_border.dart';
import 'package:eatpencil/components/bottom_sheet_menu.dart';
import 'package:eatpencil/components/general/column_with_gap.dart';
import 'package:eatpencil/components/general/image_with_blurhash.dart';
import 'package:eatpencil/components/general/row_with_gap.dart';
import 'package:eatpencil/components/general/simple_icon_button.dart';
import 'package:eatpencil/components/general/video_player.dart';
import 'package:eatpencil/components/reactions_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mfm/mfm.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    timeago.setLocaleMessages('ja', timeago.JaMessages());

    return isPureRenote
        ? ColumnWithGap(
            crossAxisAlignment: CrossAxisAlignment.start,
            gap: 10,
            children: [
              RowWithGap(
                gap: 5,
                children: [
                  Icon(
                    TablerIcons.repeat,
                    color: theme(ref).renote,
                    size: 15,
                  ),
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
              NoteContent(
                note: note.renote!,
                server: server,
              ),
            ],
          )
        : RowWithGap(
            gap: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((depth ?? 0) < 2)
                Column(
                  children: [
                    const Gap(5),
                    ClipOval(
                      child: ImageWithBlurHash(
                        imageUrl: note.user.avatarUrl.toString(),
                        blurHash: note.user.avatarBlurhash,
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ],
                ),
              Expanded(
                child: ColumnWithGap(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  gap: 2.5,
                  children: [
                    RowWithGap(
                      gap: 5,
                      children: [
                        Flexible(
                          child: RowWithGap(
                            gap: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  note.user.name ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "@${note.user.username}",
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        RowWithGap(
                          gap: 5,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              timeago.format(note.createdAt.toLocal(), locale: 'ja'),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        )
                      ],
                    ),
                    SelectionArea(
                      child: Mfm(
                        mfmText: note.text ?? "",
                      ),
                    ),
                    if (0 < imageFiles.length + videoFiles.length)
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 16 / 9,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (final file in imageFiles)
                            ImageWithBlurHash(
                              imageUrl: file.thumbnailUrl ?? file.url,
                              blurHash: file.blurhash,
                            ),
                          for (final file in videoFiles)
                            VideoPlayer(
                              url: file.url,
                            ),
                        ],
                      ),
                    if (isQuote && (depth ?? 0) < 4)
                      SizedBox(
                        width: double.infinity,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          padding: const EdgeInsets.all(15),
                          dashPattern: const [4, 4],
                          strokeWidth: 1,
                          color: theme(ref).renote,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: NoteContent(
                              note: note.renote!,
                              server: server,
                              depth: (depth ?? 0) + 1,
                            ),
                          ),
                        ),
                      ),
                    if ((depth ?? 0) < 1 && note.reactions.isNotEmpty)
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
                      RowWithGap(
                        gap: 12.5,
                        children: [
                          SimpleIconButton(
                            icon: const Icon(TablerIcons.arrow_back_up),
                            onPressed: () {
                              // TODO: Reply
                            },
                          ),
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
                          SimpleIconButton(
                            icon: const Icon(TablerIcons.plus),
                            onPressed: () {
                              // TODO: Reaction
                            },
                          ),
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
                ),
              ),
            ],
          );
  }
}
