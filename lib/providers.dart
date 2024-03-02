import 'package:eatpencil/consts.dart';
import 'package:eatpencil/models/theme.dart';
import 'package:eatpencil/utils/json_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, MkTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<MkTheme> {
  ThemeNotifier() : super(themes["Mi Green+Lime Dark"]!);

  void toggle(String themeName) {
    state = themes[themeName]!;
  }
}
// ショートハンド
MkTheme theme(WidgetRef ref) {
  return ref.watch(themeProvider);
}


final serversProvider = AsyncNotifierProvider<ServersNotifier, List<Misskey>>(
  ServersNotifier.new,
);

class ServersNotifier extends AsyncNotifier<List<Misskey>> {
  ServersNotifier() : super();

  List<Misskey> get value => state.value ?? [];

  @override
  Future<List<Misskey>> build() async {
    return (await SecureJsonStore.load<List>("servers") ?? []).map(toMisskey).toList();
  }

  Future<void> add(Misskey server) async {
    update((p0) async {
      state = const AsyncLoading();
      p0.add(server);
      await SecureJsonStore.save("servers", p0.map(toMap).toList());
      return p0;
    });
  }

  Future<void> remove(Misskey server) async {
    update((p0) async {
      state = const AsyncLoading();
      p0.remove(server);
      await SecureJsonStore.save("servers", p0.map(toMap).toList());
      return p0;
    });
  }
}

Misskey toMisskey(dynamic json) {
  return Misskey(
    host: json["host"],
    token: json["token"],
  );
}

dynamic toMap(Misskey server) {
  return {
    "host": server.host,
    "token": server.token!,
  };
}
