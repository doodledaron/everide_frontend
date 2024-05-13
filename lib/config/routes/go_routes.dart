import 'package:everide_frontend/src/screens/primary_map_screen.dart';
import 'package:everide_frontend/src/screens/test%20screens/primary_map_screen_test.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/screens/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/home",
  routes: <RouteBase>[
    GoRoute(
      path: "/home",
      name: "home",
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: "/primarymaptest", //for testin purpose
      name: "primarymaptest",
      builder: (context, state) => const PrimaryMapScreenTest(),
    ),
    GoRoute(
      path: "/primarymap",
      name: "primarymap",
      builder: (context, state) => const PrimaryMapScreen(),
    ),
    //sample : passing in data
    // GoRoute(
    //   path: "/profile",
    //   name: "profile",
    //   builder: (context, state) {
    //     final User user = state.extra as User;
    //     return const ProfilePage(user: User)
    //   },
    // ),
  ],
);
