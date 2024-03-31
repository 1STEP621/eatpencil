import 'package:eatpencil/components/general/animated_list_with_controller.dart';
import 'package:eatpencil/components/general/bottom_buttons_bar.dart';
import 'package:eatpencil/components/general/bottom_sheet_menu.dart';
import 'package:eatpencil/components/main_app_bar.dart';
import 'package:eatpencil/components/note_form.dart';
import 'package:eatpencil/components/notification.dart';
import 'package:eatpencil/components/timeline.dart';
import 'package:eatpencil/providers.dart';
import 'package:eatpencil/utils/show_modal_bottom_sheet_with_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:misskey_dart/misskey_dart.dart' hide Clip;
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _controller = AnimatedListController<INotificationsResponse>();

  void cleanConnection(Misskey server) {
    server.streamingService.close();
  }

  void connectStream(Misskey server) {
    server.startStreaming();
    server.mainStream(
      onNotification: (INotificationsResponse newNotification) {
        _controller.add(newNotification);
        Future.delayed(const Duration(seconds: 2), () {
          _controller.removeAt(_controller.contents().length - 1);
        });
      },
    );
  }

  @override
  void initState() {
    connectStream(ref.read(focusedServerProvider));
    super.initState();
  }

  @override
  void dispose() {
    cleanConnection(ref.read(focusedServerProvider));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(focusedServerProvider, (prevServer, server) {
      if (prevServer != null) cleanConnection(prevServer);
      connectStream(server);
    });

    return Scaffold(
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              const Timeline(),
              Positioned(
                right: 0,
                bottom: 0,
                width: 200,
                height: 300,
                child: Opacity(
                  opacity: 0.8,
                  child: IgnorePointer(
                    child: AnimatedListWithController<INotificationsResponse>(
                      controller: _controller,
                      reverse: true,
                      itemBuilder: (context, notification, animation) {
                        return NotificationCard(notification: notification);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButtonsBar(
        entries: [
          BottomButtonsBarEntry(
            icon: TablerIcons.menu_2,
            label: "Menu",
            onTap: () {},
          ),
          BottomButtonsBarEntry(
            icon: TablerIcons.search,
            label: "Search",
            onTap: () {
              context.push("/search");
            },
          ),
          BottomButtonsBarEntry(
            icon: TablerIcons.bell,
            label: "Notifications",
            onTap: () {
              context.push("/notifications");
            },
          ),
          BottomButtonsBarEntry(
            icon: TablerIcons.server,
            label: "Servers",
            onTap: () {
              showModalBottomSheetWithBlur(
                context: context,
                builder: (context) {
                  return BottomSheetMenu(
                    entries: [
                      for (final server in ref.watch(serversProvider).value!)
                        BottomSheetMenuEntry(
                          title: server.host,
                          onPressed: () {
                            ref.read(focusedServerProvider.notifier).update((state) => server);
                          },
                        ),
                      BottomSheetMenuEntry(
                        title: "サーバーを追加",
                        onPressed: () {
                          context.push("/auth");
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          BottomButtonsBarEntry(
            icon: TablerIcons.pencil,
            label: "Note",
            onTap: () {
              showModalBottomSheetWithBlur(
                context: context,
                builder: (context) {
                  return NoteForm(
                    server: ref.watch(focusedServerProvider),
                  );
                },
              );
            },
            gradate: true,
          ),
        ],
      ),
    );
  }
}
