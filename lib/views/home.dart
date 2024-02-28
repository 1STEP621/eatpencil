import 'package:eatpencil/components/timeline.dart';
import 'package:eatpencil/components/welcome.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eatpencil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: servers(ref).isEmpty ? const Welcome() : Timeline(server: servers(ref)[0]),
      ),
    );
  }
}
