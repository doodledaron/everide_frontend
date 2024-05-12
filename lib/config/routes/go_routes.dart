import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../src/screens/home_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/home",
  routes: <RouteBase>[
    GoRoute(
      path: "/home",
      name: "home",
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
