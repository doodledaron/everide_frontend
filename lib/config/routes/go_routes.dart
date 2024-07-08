
import 'package:everide_frontend/src/screens/add_carpooler_screen.dart';
import 'package:everide_frontend/src/screens/map_screens/choose_destination.dart';
import 'package:everide_frontend/src/screens/map_screens/choose_pick_up_screen.dart';
import 'package:everide_frontend/src/screens/feedback_screen.dart';
import 'package:everide_frontend/src/screens/map_screens/order_summary_screen.dart';
import 'package:everide_frontend/src/screens/map_screens/primary_map_screen.dart';
import 'package:everide_frontend/src/screens/reward_screen.dart';
import 'package:everide_frontend/src/screens/ride_details_screen.dart';
import 'package:everide_frontend/src/screens/test%20screens/primary_map_screen_test.dart';
import 'package:everide_frontend/src/screens/test%20screens/test_screen.dart';
import 'package:everide_frontend/src/screens/view_more_history_screen.dart';
import 'package:everide_frontend/src/screens/wallet_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      path: "/test",
      name: "test",
      builder: (context, state) => const Test(),
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
    GoRoute(
      path: "/viewmorehistory",
      name: "viewmorehistory",
      builder: (context, state) => const ViewMoreHistoryScreen(),
    ),
    GoRoute(
      path: "/ridedetails",
      name: "ridedetails",
      builder: (context, state) {
        final int rideInfoIndex = state.extra as int;
        return RideDetailScreen(index: rideInfoIndex);
      },
    ),
    GoRoute(
      path: "/choosepickup",
      name: "choosepickup",
      builder: (context, state) => const ChoosePickUpPointScreen(),
    ),
    GoRoute(
      path: "/choosedestination",
      name: "choosedestination",
      builder: (context, state) {
        final LatLng pickUpLatLng = state.extra as LatLng;
        return ChooseDestinationScreen(pickUpLatLng: pickUpLatLng);
      },
    ),
    GoRoute(
      path: "/ordersummary",
      name: "ordersummary",
      builder: (context, state) => const OrderSummaryScreen(),
    ),
    GoRoute(
      path: "/addcarpooler",
      name: "addcarpooler",
      builder: (context, state) => const AddCarpoolerScreen(),
    ),
        GoRoute(
      path: "/feedback",
      name: "feedback",
      builder: (context, state) => const FeedbackScreen(),
    ),
            GoRoute(
      path: "/wallet",
      name: "wallet",
      builder: (context, state) => const WalletScreen(),
    ),
                GoRoute(
      path: "/rewards",
      name: "rewards",
      builder: (context, state) => RewardScreen(),
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
