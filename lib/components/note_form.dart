import 'dart:math';

import 'package:eatpencil/components/general/button.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:misskey_dart/misskey_dart.dart';

class NoteForm extends ConsumerStatefulWidget {
  final Misskey server;

  const NoteForm({super.key, required this.server});

  @override
  ConsumerState<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends ConsumerState<NoteForm> {
  final placeholders = [
    "いまどうしてる？",
    "何かありましたか？",
    "何をお考えですか？",
    "言いたいことは？",
    "ここに書いてください",
    "あなたが書くのを待っています...",
  ];
  String? placeholder;
  String text = "";

  @override
  void initState() {
    placeholder = placeholders[Random().nextInt(placeholders.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme(ref).panel,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 300 + MediaQuery.of(context).viewInsets.bottom,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(color: theme(ref).fg),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              autofocus: true,
              maxLines: null,
            ),
            Button(
              text: "ノート",
              gradate: true,
              onPressed: () {
                widget.server.notes.create(
                  NotesCreateRequest(
                    text: text,
                  ),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
