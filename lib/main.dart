import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatpencil/router.dart';

void main() {
  runApp(const ProviderScope(child: Eatpencil()));
}

class Eatpencil extends ConsumerWidget {
  const Eatpencil({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]).then((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ));
    });
    return MaterialApp.router(
      title: 'Eatpencil',
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      theme: ThemeData(
        colorScheme: theme(ref).toColorScheme(),
        fontFamilyFallback: const ["Inter", "NotoSansJP"],
        useMaterial3: true,
      ),
    );
  }
}
