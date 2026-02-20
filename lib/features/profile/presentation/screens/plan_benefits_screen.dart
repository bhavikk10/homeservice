import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/providers/profile_provider.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../shared/widgets/app_button.dart';

class PlanBenefitsScreen extends ConsumerWidget {
  const PlanBenefitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider).profile;
    final planName = profile?.currentPlan.toString().split('.').last.toUpperCase() ?? 'SILVER';

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: const Text('Home'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Card with Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.successGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: CupertinoColors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text('Active', style: AppTextStyles.subtext.copyWith(color: CupertinoColors.white, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Text('CURRENT PLAN', style: AppTextStyles.subtext.copyWith(color: CupertinoColors.white, fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('$planName Plan', style: AppTextStyles.display),
              const SizedBox(height: 8),
              Text(
                'Comprehensive protection for your home\'s essentials.',
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              // Plan Benefits Section
              Row(
                children: [
                  Icon(CupertinoIcons.check_mark_circled_solid, color: AppColors.actionBlue, size: 20),
                  const SizedBox(width: 8),
                  Text('Plan Benefits', style: AppTextStyles.header),
                ],
              ),
              const SizedBox(height: 16),
              _buildBenefitCard(
                CupertinoIcons.videocam_fill,
                'Full Home Video Reporting',
                'Monthly video walk-throughs and safety checks.',
              ),
              const SizedBox(height: 12),
              _buildBenefitCard(
                CupertinoIcons.house_fill,
                'Comprehensive Maintenance',
                'All standard plumbing, electrical, and HVAC items.',
              ),
              const SizedBox(height: 12),
              _buildBenefitCard(
                CupertinoIcons.headphones,
                'Priority Support',
                'Dedicated specialist assigned to your account.',
              ),
              const SizedBox(height: 12),
              _buildBenefitCard(
                CupertinoIcons.calendar,
                'Quarterly Inspections',
                'On-site structural and safety check every 90 days.',
              ),
              const SizedBox(height: 32),
              // View Other Plans Button
              AppButton(
                text: 'View Other Plans →',
                onPressed: () {
                  AppNavigator.pushSubscriptionPlans(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.actionBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.actionBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.header),
                const SizedBox(height: 4),
                Text(description, style: AppTextStyles.subtext),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
