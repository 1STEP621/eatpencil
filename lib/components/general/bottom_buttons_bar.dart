import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomButtonsBarEntry {
  final IconData icon;
  final String label;
  final void Function() onTap;
  final bool primary;
  final bool gradate;

  BottomButtonsBarEntry({
    required this.icon,
    required this.label,
    required this.onTap,
    this.primary = false,
    this.gradate = false,
  });
}

class BottomButtonsBar extends ConsumerWidget {
  final List<BottomButtonsBarEntry> entries;

  const BottomButtonsBar({super.key, required this.entries});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: ThemeData(
        splashColor: theme(ref).buttonBg,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme(ref).panel,
        selectedItemColor: theme(ref).fg,
        unselectedItemColor: theme(ref).fg,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          for (final entry in entries)
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: () {
                    if (entry.primary) return theme(ref).accent;
                    if (entry.gradate) return null;
                    return theme(ref).buttonBg;
                  }(),
                  gradient: entry.gradate
                      ? LinearGradient(
                          colors: [
                            theme(ref).buttonGradateA,
                            theme(ref).buttonGradateB,
                          ],
                        )
                      : null,
                ),
                padding: const EdgeInsets.all(16),
                child: Icon(
                  entry.icon,
                  color: (entry.primary || entry.gradate) ? theme(ref).fgOnAccent : theme(ref).fg,
                ),
              ),
              label: "Menu",
            ),
        ],
        onTap: (index) {
          // BottomNavigationBarをボタン的に使うのあんまりイケてなさそうだからどうにかしたい
          entries[index].onTap();
        },
      ),
    );
  }
}
