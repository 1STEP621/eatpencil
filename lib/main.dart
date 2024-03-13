import 'package:eatpencil/providers.dart';
import 'package:eatpencil/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

void main() {
  MediaKit.ensureInitialized();
  runApp(const ProviderScope(child: Eatpencil()));
}

class Eatpencil extends ConsumerWidget {
  const Eatpencil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Eatpencil',
      supportedLocales: const [Locale('ja', 'JP')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerDelegate: ref.watch(goRouterProvider).routerDelegate,
      routeInformationParser: ref.watch(goRouterProvider).routeInformationParser,
      routeInformationProvider: ref.watch(goRouterProvider).routeInformationProvider,
      theme: ThemeData(
        colorScheme: theme(ref).toColorScheme(),
        fontFamilyFallback: const ["Inter", "NotoSansJP"],
        useMaterial3: true,
      ),
    );
  }
}
