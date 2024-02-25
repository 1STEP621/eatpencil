import 'package:eatpencil/components/general/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:mfm/mfm.dart';
import 'package:eatpencil/providers.dart';

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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.user.name ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Mfm(mfmText: note.text ?? ""),
            Row(
              children: [
                IconButton(
                  icon: const Icon(TablerIcons.arrow_back_up),
                  onPressed: () {},
                  iconSize: 20,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  padding: EdgeInsets.zero,
                  color: theme(ref).fg,
                ),
                const Space(width: 20),
                IconButton(
                  icon: const Icon(TablerIcons.repeat),
                  onPressed: () {},
                  iconSize: 20,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  padding: EdgeInsets.zero,
                  color: theme(ref).fg,
                ),
                const Space(width: 20),
                IconButton(
                  icon: const Icon(TablerIcons.plus),
                  onPressed: () {},
                  iconSize: 20,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  padding: EdgeInsets.zero,
                  color: theme(ref).fg,
                ),
                const Space(width: 20),
                IconButton(
                  icon: const Icon(TablerIcons.dots),
                  onPressed: () {},
                  iconSize: 20,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  alignment: Alignment.center,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                  ),
                  color: theme(ref).fg,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
