import 'package:eatpencil/components/general/button.dart';
import 'package:eatpencil/components/general/panel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eatpencil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Panel(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Eatpencilへようこそ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                const Text("最初のサーバーを追加しましょう！"),
                const Gap(10),
                Button(
                  onPressed: () {
                    context.push("/auth");
                  },
                  gradate: true,
                  rounded: true,
                  text: "サーバーを追加",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
