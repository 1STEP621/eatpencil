import 'package:flutter/material.dart';
import 'package:misskey_dart/misskey_dart.dart';

class Notes extends StatelessWidget {
  final List<Misskey> notes;
  const Notes({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Notes"),
    );
  }
}
