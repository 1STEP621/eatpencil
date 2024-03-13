import 'package:eatpencil/components/main_app_bar.dart';
import 'package:eatpencil/components/notifications.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MainAppBar(),
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
          child: const Notifications(),
        ),
      ),
    );
  }
}
