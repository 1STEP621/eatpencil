import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class Entry {
  final String title;
  final IconData icon;
  final void Function() onPressed;

  const Entry({
    required this.title,
    required this.icon,
    required this.onPressed,
  });
}

class BottomSheetMenu extends ConsumerWidget {
  final List<Entry> entries;

  const BottomSheetMenu({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
              leading: Icon(
                entry.icon,
                color: theme(ref).fg,
              ),
              onTap: () {
                entry.onPressed();
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
