import 'package:eatpencil/components/general/image_with_blurhash.dart';
import 'package:flutter/material.dart';
import 'package:misskey_dart/misskey_dart.dart';

class Avatar extends StatelessWidget {
  final User user;

  const Avatar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ImageWithBlurHash(
        imageUrl: user.avatarUrl.toString(),
        blurHash: user.avatarBlurhash,
        fit: BoxFit.cover,
        width: 45,
        height: 45,
      ),
    );
  }
}
