import 'package:eatpencil/components/main_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Text("Notifications"),
      ),
    );
  }
}
