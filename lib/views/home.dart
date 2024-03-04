import 'package:eatpencil/components/bottom_buttons_bar.dart';
import 'package:eatpencil/components/note_form.dart';
import 'package:eatpencil/components/timeline.dart';
import 'package:eatpencil/components/welcome.dart';
import 'package:eatpencil/providers.dart';
import 'package:eatpencil/utils/show_modal_bottom_sheet_with_blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabler_icons_for_flutter/tabler_icons_for_flutter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eatpencil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: (ref.watch(serversProvider).value ?? []).isEmpty
            ? const Welcome()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme(ref).divider,
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: Timeline(server: ref.watch(serversProvider).value![0]),
              ),
      ),
      bottomNavigationBar: (ref.watch(serversProvider).value ?? []).isEmpty
          ? null
          : BottomButtonsBar(
              entries: [
                Entry(
                  icon: TablerIcons.menu_2,
                  label: "Menu",
                  onTap: () {},
                ),
                Entry(
                  icon: TablerIcons.home,
                  label: "Home",
                  onTap: () {},
                ),
                Entry(
                  icon: TablerIcons.bell,
                  label: "Notifications",
                  onTap: () {},
                ),
                Entry(
                  icon: TablerIcons.server,
                  label: "Servers",
                  onTap: () {},
                ),
                Entry(
                  icon: TablerIcons.pencil,
                  label: "Note",
                  onTap: () {
                    showModalBottomSheetWithBlur(
                      context: context,
                      builder: (context) {
                        return NoteForm(server: ref.watch(serversProvider).value![0]);
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
