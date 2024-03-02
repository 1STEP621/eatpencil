import 'package:eatpencil/consts.dart';
import 'package:eatpencil/models/theme.dart';
import 'package:eatpencil/utils/json_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:misskey_dart/misskey_dart.dart';

final themeProvider = Provider((ref) {
  return themes["Mi Astro Dark"];
});

MkTheme theme(ref) {
  return ref.watch(themeProvider);
}

final serversAsyncNotifierProvider = AsyncNotifierProvider<ServersAsyncNotifier, List<Misskey>>(
  ServersAsyncNotifier.new,
);

class ServersAsyncNotifier extends AsyncNotifier<List<Misskey>> {
  ServersAsyncNotifier() : super();

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
