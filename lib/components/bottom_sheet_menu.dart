import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomSheetMenuEntry {
  final String title;
  final IconData? icon;
  final void Function() onPressed;

  const BottomSheetMenuEntry({
    required this.title,
    this.icon,
    required this.onPressed,
  });
}

class BottomSheetMenu extends ConsumerWidget {
  final List<BottomSheetMenuEntry> entries;

  const BottomSheetMenu({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: theme(ref).panel,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final entry in entries)
            ListTile(
              title: Text(entry.title),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              leading: entry.icon == null
                  ? null
                  : Icon(
                      entry.icon,
                      color: theme(ref).fg,
                    ),
              onTap: () {
                entry.onPressed();
                context.pop();
              },
            ),
        ],
      ),
    );
  }
}
