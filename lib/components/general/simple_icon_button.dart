import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SimpleIconButton extends ConsumerWidget {
  final Widget icon;
  final void Function() onPressed;

  const SimpleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      iconSize: 17.5,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      padding: const EdgeInsets.all(10),
      color: theme(ref).fgTransparent,
    );
  }
}
