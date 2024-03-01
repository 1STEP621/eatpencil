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

final serversProvider = FutureProvider((ref) async {
  return (await SecureJsonStore.load("servers"));
});

List<Misskey> servers(ref) {
  return (ref.watch(serversProvider)?.value ?? []).map<Misskey>((e) {
    return Misskey(
      host: e["host"],
      token: e["token"],
    );
  }).toList();
}
