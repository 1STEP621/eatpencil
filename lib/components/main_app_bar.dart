import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatpencil/providers.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: FutureBuilder(
        future: ref.watch(focusedServerProvider)!.meta(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CachedNetworkImage(
              imageUrl: snapshot.data!.iconUrl.toString(),
              width: 30,
            );
          }
          return const SizedBox.shrink();
        },
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
