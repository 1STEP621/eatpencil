import 'package:eatpencil/providers.dart';
import 'package:eatpencil/views/auth.dart';
import 'package:eatpencil/views/home.dart';
import 'package:eatpencil/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider(
  (ref) => GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/welcome",
        name: "/welcome",
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const WelcomePage(),
          );
        },
      ),
      GoRoute(
        path: "/home",
        name: "home",
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: "/auth",
        name: "auth",
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const AuthPage(),
          );
        },
      ),
    ],
  ),
);
