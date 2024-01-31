import 'package:eatpencil/views/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eatpencil/views/home.dart';

final goRouter = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: "/home",
      name: "home",
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        );
      }
    ),
    GoRoute(
        path: "/auth",
        name: "auth",
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const AuthPage(),
          );
        }
    ),
  ],
);
