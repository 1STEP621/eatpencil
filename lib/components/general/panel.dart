import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Panel extends ConsumerWidget {
  final double? padding;
  final Widget child;

  const Panel({
    super.key,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(padding ?? 30),
      decoration: BoxDecoration(
        color: theme(ref).panel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
