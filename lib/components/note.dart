import 'package:eatpencil/components/general/simple_icon_button.dart';
import 'package:eatpencil/components/general/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:mfm/mfm.dart';
import '../providers.dart';

class NoteCard extends ConsumerWidget {
  final Note note;

  const NoteCard({
    required this.note,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRenote = note.renote != null;
    final isQuote = isRenote &&
        (note.text != null ||
            note.cw != null ||
            note.files.isNotEmpty ||
            note.poll != null);
    final isPureRenote = isRenote && !isQuote;
    final isReply = note.reply != null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPureRenote)
              Column(
                children: [
                  RenoterIndicator(note: note),
                  const Space(height: 10),
                ],
              ),
            Text(
              (isPureRenote ? note.renote!.user.name : note.user.name) ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Mfm(mfmText: isPureRenote ? note.renote!.text : note.text),
            if (isQuote)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme(ref).renote,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: NoteCard(
                  note: note.renote!,
                ),
              ),
            Row(
              children: [
                SimpleIconButton(
                  icon: const Icon(TablerIcons.arrow_back_up),
                  onPressed: () {},
                ),
                const Space(width: 20),
                SimpleIconButton(
                  icon: const Icon(TablerIcons.repeat),
                  onPressed: () {},
                ),
                const Space(width: 20),
                SimpleIconButton(
                  icon: const Icon(TablerIcons.plus),
                  onPressed: () {},
                ),
                const Space(width: 20),
                SimpleIconButton(
                  icon: const Icon(TablerIcons.dots),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RenoterIndicator extends ConsumerWidget {
  final Note note;
  const RenoterIndicator({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
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
    );
  }
}
