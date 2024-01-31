import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Space extends ConsumerWidget {
  final double? width;
  final double? height;
  const Space({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width ?? 0,
      height: height ?? 0,
    );
  }
}