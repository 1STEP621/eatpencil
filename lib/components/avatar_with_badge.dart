import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart' hide Clip;
import 'package:eatpencil/providers.dart';
import 'package:eatpencil/components/avatar.dart';

class AvatarWithBadge extends ConsumerWidget {
  final User user;
  final Widget badge;
  const AvatarWithBadge({super.key, required this.user, required this.badge});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Avatar(user: user),
        Positioned(
          right: -4,
          bottom: -4,
          child: ClipOval(
            child: Container(
              width: 26,
              height: 26,
              color: theme(ref).panel,
              alignment: Alignment.center,
              child: ClipOval(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: badge,
                ),
              )
            ),
          ),
        ),
      ],
    );
  }
}
