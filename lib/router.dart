import 'package:eatpencil/pages/auth.dart';
import 'package:eatpencil/pages/home.dart';
import 'package:eatpencil/pages/loading.dart';
import 'package:eatpencil/pages/notifications.dart';
import 'package:eatpencil/pages/search.dart';
import 'package:eatpencil/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider(
  (ref) => GoRouter(
    initialLocation: "/",
    routes: [
      // サーバー情報を取得し終わるまでロード画面を見せる
      GoRoute(
        path: "/",
        name: "/",
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const LoadingPage(),
          );
        },
      ),
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
        path: "/search",
        name: "search",
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const SearchPage(),
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
        path: "/notifications",
        name: "notifications",
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const NotificationsPage(),
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
