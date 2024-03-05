import 'package:eatpencil/components/main_bottom_buttons_bar.dart';
import 'package:eatpencil/components/timeline.dart';
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: theme(ref).divider,
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: const Timeline(),
        ),
      ),
      bottomNavigationBar: const MainBottomButtonsBar(),
    );
  }
}
