import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eatpencil/components/avatar.dart';
import 'package:eatpencil/components/general/bottom_sheet_menu.dart';
import 'package:eatpencil/components/general/column_with_gap.dart';
import 'package:eatpencil/components/general/image_with_blurhash.dart';
import 'package:eatpencil/components/general/row_with_gap.dart';
import 'package:eatpencil/components/general/simple_icon_button.dart';
import 'package:eatpencil/components/general/video_player.dart';
import 'package:eatpencil/components/mfm.dart';
import 'package:eatpencil/components/reactions_viewer.dart';
import 'package:eatpencil/providers.dart';
import 'package:eatpencil/utils/show_modal_bottom_sheet_with_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoteContent extends ConsumerWidget {
  final Note note;
  final int? depth;

  const NoteContent({
    super.key,
    required this.note,
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
                    child: CustomSimpleMfm(
                      "${note.user.name ?? note.user.username}がリノート",
                      overrideEmojis: note.emojis,
                      style: TextStyle(
                        color: theme(ref).renote,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              NoteContent(
                note: note.renote!,
              ),
            ],
          )
        : RowWithGap(
            gap: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((depth ?? 0) < 2) Avatar(user: note.user),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: CustomSimpleMfm(
                                  note.user.name ?? note.user.username,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (final role in note.user.badgeRoles)
                              if (role.iconUrl != null)
                                CachedNetworkImage(
                                  imageUrl: role.iconUrl.toString(),
                                  height: 15,
                                ),
                            Text(
                              timeago.format(note.createdAt.toLocal(), locale: 'ja'),
                              textAlign: TextAlign.right,
                            ),
                            if (note.visibility == NoteVisibility.home)
                              Icon(
                                TablerIcons.home,
                                color: theme(ref).fg,
                                size: 15,
                              ),
                            if (note.visibility == NoteVisibility.followers)
                              Icon(
                                TablerIcons.lock,
                                color: theme(ref).fg,
                                size: 15,
                              ),
                            if (note.visibility == NoteVisibility.specified)
                              Icon(
                                TablerIcons.mail,
                                color: theme(ref).fg,
                                size: 15,
                              ),
                            if (note.localOnly)
                              Icon(
                                TablerIcons.rocket_off,
                                color: theme(ref).fg,
                                size: 15,
                              ),
                          ],
                        )
                      ],
                    ),
                    SelectionArea(
                      child: CustomNormalMfm(
                        note.text ?? "",
                        overrideEmojis: note.emojis,
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
                          // for (final file in videoFiles)
                          //   VideoPlayer(
                          //     url: file.url,
                          //   ),
                        ],
                      ),
                    if (isQuote && (depth ?? 0) < 4)
                      SizedBox(
                        width: double.infinity,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          padding: const EdgeInsets.all(15),
                          dashPattern: const [2, 2],
                          strokeWidth: 1,
                          color: theme(ref).renote,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: NoteContent(
                              note: note.renote!,
                              depth: (depth ?? 0) + 1,
                            ),
                          ),
                        ),
                      ),
                    if ((depth ?? 0) < 1 && note.reactions.isNotEmpty)
                      ReactionsViewer(
                        note: note,
                        onReactionTap: (reaction) {
                          ref.watch(focusedServerProvider).notes.reactions.create(
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
                              showModalBottomSheetWithBlur(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetMenu(
                                    entries: [
                                      BottomSheetMenuEntry(
                                        title: "リノート",
                                        icon: TablerIcons.repeat,
                                        onPressed: () {
                                          ref.watch(focusedServerProvider).notes.create(
                                                NotesCreateRequest(
                                                  renoteId: note.id,
                                                ),
                                              );
                                        },
                                      ),
                                      BottomSheetMenuEntry(
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
                              showModalBottomSheetWithBlur(
                                context: context,
                                builder: (BuildContext context) {
                                  return BottomSheetMenu(
                                    entries: [
                                      BottomSheetMenuEntry(
                                        title: "詳細",
                                        icon: TablerIcons.info_circle,
                                        onPressed: () {
                                          // TODO: Detail
                                        },
                                      ),
                                      BottomSheetMenuEntry(
                                        title: "内容をコピー",
                                        icon: TablerIcons.copy,
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(text: note.text ?? ""),
                                          );
                                        },
                                      ),
                                      BottomSheetMenuEntry(
                                        title: "リンクをコピー",
                                        icon: TablerIcons.link,
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: "https://${ref.watch(focusedServerProvider).host}/notes/${note.id}",
                                            ),
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
