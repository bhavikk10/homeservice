import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show LinearProgressIndicator;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/providers/profile_provider.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../shared/widgets/app_button.dart';

class PlanDetailScreen extends ConsumerWidget {
  final SubscriptionTier tier;
  const PlanDetailScreen({super.key, required this.tier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider).profile;
    final isActive = profile?.currentPlan == tier;
    
    final planData = _getPlanData(tier);
    final planName = planData['name'] as String;
    final planDescription = planData['description'] as String;
    final planImage = planData['image'] as String;
    final benefits = planData['benefits'] as List<Map<String, dynamic>>;
    final usageMetrics = planData['usage'] as Map<String, dynamic>?;

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
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Plan Card with Image
              Container(
                height: 250,
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        planImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.actionBlue,
                            child: Center(
                              child: Icon(CupertinoIcons.house_fill, color: CupertinoColors.white, size: 64),
                            ),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              CupertinoColors.black.withOpacity(0.3),
                              CupertinoColors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CURRENT PLAN',
                              style: AppTextStyles.subtext.copyWith(
                                color: CupertinoColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$planName Plan',
                                  style: AppTextStyles.display.copyWith(
                                    color: CupertinoColors.white,
                                    fontSize: 24,
                                  ),
                                ),
                                if (isActive)
                                  Container(
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
                                        Text(
                                          'Active',
                                          style: AppTextStyles.subtext.copyWith(
                                            color: CupertinoColors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              planDescription,
                              style: AppTextStyles.body.copyWith(
                                color: CupertinoColors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Usage Metrics Section (only for active plan)
              if (isActive && usageMetrics != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Usage Overview', style: AppTextStyles.header),
                      const SizedBox(height: 16),
                      _buildUsageCard(
                        'Insurance Coverage',
                        '₹${usageMetrics['insuranceUsed']} used',
                        '₹${usageMetrics['insuranceTotal']} total',
                        usageMetrics['insuranceUsed'] / usageMetrics['insuranceTotal'],
                      ),
                      const SizedBox(height: 12),
                      _buildUsageCard(
                        'Plan Duration',
                        '${usageMetrics['monthsUsed']} months used',
                        '${usageMetrics['monthsTotal']} months total',
                        usageMetrics['monthsUsed'] / usageMetrics['monthsTotal'],
                      ),
                      const SizedBox(height: 12),
                      _buildUsageCard(
                        'Video Inspections',
                        '${usageMetrics['inspectionsUsed']} completed',
                        '${usageMetrics['inspectionsTotal']} available',
                        usageMetrics['inspectionsUsed'] / usageMetrics['inspectionsTotal'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
              // Plan Benefits Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.check_mark_circled_solid, color: AppColors.actionBlue, size: 20),
                        const SizedBox(width: 8),
                        Text('Plan Benefits', style: AppTextStyles.header),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...benefits.map((benefit) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildBenefitCard(
                        benefit['icon'] as IconData,
                        benefit['title'] as String,
                        benefit['description'] as String,
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // View Other Plans Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AppButton(
                  text: 'View Other Plans →',
                  onPressed: () {
                    AppNavigator.pushSubscriptionPlans(context);
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getPlanData(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.silver:
        return {
          'name': 'Silver',
          'description': 'Comprehensive protection for your home\'s essentials.',
          'image': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400&h=300&fit=crop',
          'benefits': [
            {
              'icon': CupertinoIcons.videocam_fill,
              'title': 'Full Home Video Reporting',
              'description': 'Monthly video walk-throughs and safety checks.',
            },
            {
              'icon': CupertinoIcons.house_fill,
              'title': 'Comprehensive Maintenance',
              'description': 'All standard plumbing, electrical, and HVAC items.',
            },
            {
              'icon': CupertinoIcons.headphones,
              'title': 'Priority Support',
              'description': 'Dedicated specialist assigned to your account.',
            },
            {
              'icon': CupertinoIcons.calendar,
              'title': 'Quarterly Inspections',
              'description': 'On-site structural and safety check every 90 days.',
            },
          ],
          'usage': {
            'insuranceUsed': 40000,
            'insuranceTotal': 200000,
            'monthsUsed': 4,
            'monthsTotal': 12,
            'inspectionsUsed': 1,
            'inspectionsTotal': 4,
          },
        };
      case SubscriptionTier.gold:
        return {
          'name': 'Gold',
          'description': 'Enhanced protection with premium benefits and priority service.',
          'image': 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=400&h=300&fit=crop',
          'benefits': [
            {
              'icon': CupertinoIcons.videocam_fill,
              'title': 'Full Home Video Reporting',
              'description': 'Bi-weekly video walk-throughs and safety checks.',
            },
            {
              'icon': CupertinoIcons.house_fill,
              'title': 'Comprehensive Maintenance',
              'description': 'All standard and premium plumbing, electrical, HVAC, and appliance items.',
            },
            {
              'icon': CupertinoIcons.headphones,
              'title': 'Priority Support',
              'description': 'Dedicated specialist with 24/7 availability.',
            },
            {
              'icon': CupertinoIcons.calendar,
              'title': 'Monthly Inspections',
              'description': 'On-site structural and safety check every 30 days.',
            },
            {
              'icon': CupertinoIcons.shield_fill,
              'title': 'Extended Warranty',
              'description': '90-day warranty on all repairs and services.',
            },
          ],
          'usage': null, // Not active
        };
      case SubscriptionTier.diamond:
        return {
          'name': 'Diamond',
          'description': 'Ultimate protection with exclusive benefits and white-glove service.',
          'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&h=300&fit=crop',
          'benefits': [
            {
              'icon': CupertinoIcons.videocam_fill,
              'title': 'Full Home Video Reporting',
              'description': 'Weekly video walk-throughs and comprehensive safety checks.',
            },
            {
              'icon': CupertinoIcons.house_fill,
              'title': 'Comprehensive Maintenance',
              'description': 'All items including premium appliances, smart home systems, and luxury fixtures.',
            },
            {
              'icon': CupertinoIcons.headphones,
              'title': 'Priority Support',
              'description': 'Personal concierge with instant response and dedicated account manager.',
            },
            {
              'icon': CupertinoIcons.calendar,
              'title': 'Bi-weekly Inspections',
              'description': 'On-site structural and safety check every 15 days.',
            },
            {
              'icon': CupertinoIcons.shield_fill,
              'title': 'Extended Warranty',
              'description': '180-day warranty on all repairs and services.',
            },
            {
              'icon': CupertinoIcons.star_fill,
              'title': 'Exclusive Benefits',
              'description': 'Access to premium contractors and priority scheduling.',
            },
          ],
          'usage': null, // Not active
        };
    }
  }

  Widget _buildUsageCard(String title, String used, String total, double progress) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.header),
              Text(
                used,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.actionBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: AppColors.backgroundLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.actionBlue),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            total,
            style: AppTextStyles.subtext.copyWith(color: AppColors.textSecondary),
          ),
        ],
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
