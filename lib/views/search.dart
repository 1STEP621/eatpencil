import 'package:eatpencil/components/main_app_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Text("Search"),
      ),
    );
  }
}
