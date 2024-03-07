import 'package:eatpencil/components/main_bottom_buttons_bar.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eatpencil"),
      ),
      body: const Center(
        child: Text("Notifications"),
      ),
      bottomNavigationBar: const MainBottomButtonsBar(),
    );
  }
}
