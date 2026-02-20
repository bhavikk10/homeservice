import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/location_access_screen.dart';
import '../../features/asset_inventory/presentation/screens/inventory_instruction_screen.dart';
import '../../features/asset_inventory/presentation/screens/scanning_results_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/service/presentation/screens/service_detail_screen.dart';
import '../../features/service/presentation/screens/capture_problem_screen.dart';
import '../../features/service/presentation/screens/tracking_timeline_screen.dart';
import '../../features/profile/presentation/screens/user_details_screen.dart';
import '../../features/profile/presentation/screens/subscription_plans_screen.dart';
import '../../shared/widgets/scaffold_with_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');
final _sectionBNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionBNav');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: '/location-access',
      builder: (context, state) => const LocationAccessScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
          routes: [
            GoRoute(
              path: '/service-hub',
              builder: (context, state) => const HomeScreen(),
              routes: [
                 GoRoute(
                  path: 'service-detail/:name',
                  builder: (context, state) {
                    final name = state.pathParameters['name']!;
                    return ServiceDetailScreen(serviceName: name);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionBNavigatorKey,
          routes: [
            GoRoute(
              path: '/user-details',
              builder: (context, state) => const UserDetailsScreen(),
              routes: [
                 GoRoute(
                  path: 'subscription-plans',
                  builder: (context, state) => const SubscriptionPlansScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/asset-inventory-instruction',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const InventoryInstructionScreen(),
    ),
    GoRoute(
      path: '/scanning-results',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ScanningResultsScreen(),
    ),
    GoRoute(
      path: '/capture-problem',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CaptureProblemScreen(),
    ),
    GoRoute(
      path: '/tracking-timeline', // Note: If this is accessed from Service Hub, maybe it should be nested, but it seems like a separate full screen flow
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TrackingTimelineScreen(),
    ),
  ],
);
