import 'package:flutter/cupertino.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/location_access_screen.dart';
import '../../features/asset_inventory/presentation/screens/inventory_instruction_screen.dart';
import '../../features/asset_inventory/presentation/screens/scanning_results_screen.dart';
import '../../features/service/presentation/screens/service_detail_screen.dart';
import '../../features/service/presentation/screens/capture_problem_screen.dart';
import '../../features/service/presentation/screens/tracking_timeline_screen.dart';
import '../../features/profile/presentation/screens/user_details_screen.dart';
import '../../features/profile/presentation/screens/subscription_plans_screen.dart';
import '../../features/profile/presentation/screens/profile_dashboard_screen.dart';
import '../../features/profile/presentation/screens/plan_benefits_screen.dart';
import '../../features/profile/presentation/screens/plan_detail_screen.dart';
import '../../features/service/presentation/screens/active_requests_screen.dart';
import '../../features/asset_inventory/presentation/screens/add_item_screen.dart';
import '../../core/providers/profile_provider.dart';
import 'main_tab_scaffold.dart';

class AppNavigator {
  static void pushLogin(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  static void pushOtp(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const OtpScreen()),
    );
  }

  static void pushLocationAccess(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const LocationAccessScreen()),
    );
  }

  static void pushInventoryInstruction(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const InventoryInstructionScreen()),
    );
  }

  static void pushScanningResults(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const ScanningResultsScreen()),
    );
  }

  static void pushServiceDetail(BuildContext context, String serviceName) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => ServiceDetailScreen(serviceName: serviceName),
      ),
    );
  }

  static void pushCaptureProblem(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const CaptureProblemScreen()),
    );
  }

  static void pushTrackingTimeline(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const TrackingTimelineScreen()),
    );
  }

  static void pushUserDetails(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const UserDetailsScreen()),
    );
  }

  static void pushSubscriptionPlans(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const SubscriptionPlansScreen()),
    );
  }

  static void pushProfileDashboard(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const ProfileDashboardScreen()),
    );
  }

  static void pushPlanBenefits(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const PlanBenefitsScreen()),
    );
  }

  static void pushActiveRequests(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const ActiveRequestsScreen()),
    );
  }

  static void pushPlanDetail(BuildContext context, SubscriptionTier tier) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => PlanDetailScreen(tier: tier)),
    );
  }

  static void pushAddItem(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const AddItemScreen()),
    );
  }

  static void replaceWithMain(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => const MainTabScaffold()),
      (route) => false,
    );
  }
}
