import 'package:eatpencil/components/panel.dart';
import 'package:eatpencil/components/space.dart';
import 'package:eatpencil/utils/json_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eatpencil/utils/ratio_sizing.dart';
import 'package:eatpencil/providers.dart';
import 'package:go_router/go_router.dart';
import 'package:misskey_dart/misskey_dart.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends ConsumerState<AuthPage> {
  String host = "";
  String session = "";
  bool isUrlLaunched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("サーバーを追加"),
      ),
      body: Center(
        child: Panel(
          child: SizedBox(
            width: RatioSizing.ratioW(context, 0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    host = value;
                  },
                  decoration: InputDecoration(
                    hintText: "サーバードメイン (e.g. misskey.io)",
                    hintStyle: TextStyle(
                      color: theme(context).fgTransparent,
                    ),
                  ),
                ),
                const Space(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        startAuth();
                      },
                      child: Text(isUrlLaunched ? "もう一回！" : "認証する！"),
                    ),
                    if (isUrlLaunched) ...[
                      const Space(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          finishAuth();
                        },
                        child: const Text("認証してきた"),
                      ),
                    ]
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startAuth() {
    session = const Uuid().v4();
    final url = MisskeyServer().buildMiAuthURL(
      host,
      session,
      name: "Eatpencil",
      permission: Permission.values,
    );
    launchUrl(url);
    setState(() {
      isUrlLaunched = true;
    });
  }

  Future<void> finishAuth() async {
    final content = await SecureJsonStore.load<List<dynamic>>("servers") ?? [];
    content.add({
      "host": host,
      "token": await MisskeyServer().checkMiAuthToken(host, session),
    });
    SecureJsonStore.save("servers", content).then((_) async {
      context.pop();
      await SecureJsonStore.load("servers");
    });
  }
}
