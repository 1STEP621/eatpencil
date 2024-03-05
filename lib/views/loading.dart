import 'package:eatpencil/components/loading_circle.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../router.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(serversProvider, (previous, next) {
      if (next.hasValue && !next.isLoading && !next.hasError) {
        if (next.value!.isEmpty) {
          ref.read(goRouterProvider).go("/welcome");
        } else {
          ref.read(goRouterProvider).go("/home");
        }
      }
    });

    return const Scaffold(
      body: Center(
        child: LoadingCircle(),
      ),
    );
  }
}
