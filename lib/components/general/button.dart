import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Button extends ConsumerWidget {
  final String text;
  final bool primary;
  final bool gradate;
  final bool rounded;
  final bool danger;
  final void Function() onPressed;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = false,
    this.gradate = false,
    this.rounded = false,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = () {
      if (primary) {
        return theme(ref).accent;
      } else if (danger) {
        return theme(ref).buttonBg;
      } else {
        return theme(ref).buttonBg;
      }
    }();
    final foregroundColor = () {
      if (primary) {
        return theme(ref).fgOnAccent;
      } else if (danger) {
        return const Color(0xffff2a2a);
      } else {
        return theme(ref).fg;
      }
    }();

    final bold = primary || gradate;

    return gradate
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(rounded ? 100 : 5),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme(ref).buttonGradateA,
                    theme(ref).buttonGradateB,
                  ],
                ),
                borderRadius: BorderRadius.circular(rounded ? 100 : 5),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: theme(ref).fgOnAccent,
                    fontWeight: bold ? FontWeight.bold : null,
                  ),
                ),
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(rounded ? 100 : 5),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: foregroundColor,
                fontWeight: bold ? FontWeight.bold : null,
              ),
            ),
          );
  }
}
