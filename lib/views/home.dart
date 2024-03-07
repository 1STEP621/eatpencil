import 'package:eatpencil/components/main_app_bar.dart';
import 'package:eatpencil/components/timeline.dart';
import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';
import 'package:eatpencil/components/general/bottom_sheet_menu.dart';
import 'package:eatpencil/components/general/bottom_buttons_bar.dart';
import 'package:eatpencil/components/note_form.dart';
import 'package:eatpencil/utils/show_modal_bottom_sheet_with_blur.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: theme(ref).divider,
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: const Timeline(),
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
            icon: TablerIcons.home,
            label: "Home",
            onTap: () {
              context.push("/home");
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
                    server: ref.watch(focusedServerProvider)!,
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
