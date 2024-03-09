import 'package:eatpencil/components/general/custom_cached_network_image.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: ref.watch(metaProvider).value == null
          ? const SizedBox.shrink()
          : CustomCachedNetworkImage(
              imageUrl: ref.watch(metaProvider).value!.iconUrl.toString(),
              width: 30,
            ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
