import 'package:eatpencil/components/general/panel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
            ElevatedButton(
              onPressed: () {
                context.push("/auth");
              },
              child: const Text("サーバーを追加"),
            ),
          ],
        ),
      ),
    );
  }
}
