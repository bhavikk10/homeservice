import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/providers/profile_provider.dart';
import '../../../../core/navigation/app_navigator.dart';

class ProfileDashboardScreen extends ConsumerWidget {
  const ProfileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider).profile;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.location_solid, color: AppColors.actionBlue, size: 16),
            const SizedBox(width: 4),
            Text('Gurugram, Haryana', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
            Icon(CupertinoIcons.chevron_down, size: 16),
          ],
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            AppNavigator.pushActiveRequests(context);
          },
          child: Icon(CupertinoIcons.bell, color: CupertinoColors.black),
        ),
      ),
      child: SafeArea(
        bottom: false,
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100, top: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Verified Customer Profile - Fixed alignment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.check_mark_circled_solid, color: AppColors.actionBlue, size: 20),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Verified Customer Profile',
                              style: AppTextStyles.header,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildPillButton('MY POLICY'),
                        const SizedBox(width: 8),
                        _buildPillButton('MY SERVICE'),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 12),
              // User Card - with avatar and edit icon
              Container(
                padding: const EdgeInsets.all(20),
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppNavigator.pushUserDetails(context);
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFDE8E8),
                              image: profile?.avatarUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(profile!.avatarUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: profile?.avatarUrl == null
                                ? Center(
                                    child: Text(
                                      profile?.fullName.substring(0, 1) ?? 'A',
                                      style: AppTextStyles.title,
                                    ),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.actionBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                CupertinoIcons.pencil,
                                color: CupertinoColors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profile?.fullName ?? 'Alex Harrison', style: AppTextStyles.title),
                          const SizedBox(height: 4),
                          Text(
                            '${profile?.userId ?? '99999'} • ID: ${profile?.id ?? '882941'}',
                            style: AppTextStyles.subtext,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // MY PLANS Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('MY PLANS', style: AppTextStyles.header),
                ],
              ),
              const SizedBox(height: 16),
              _buildPlanCard(context, 'Silver', 'Provides Home Video and All items coverage.', true, SubscriptionTier.silver),
              const SizedBox(height: 12),
              _buildPlanCard(context, 'Gold', null, false, SubscriptionTier.gold),
              const SizedBox(height: 12),
              _buildPlanCard(context, 'Diamond', null, false, SubscriptionTier.diamond),
              const SizedBox(height: 24),
              // PROFILE DETAILS Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('PROFILE DETAILS', style: AppTextStyles.header),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      AppNavigator.pushUserDetails(context);
                    },
                    child: Text('Manage', style: AppTextStyles.subtext.copyWith(color: AppColors.actionBlue)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
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
                    _buildDetailRowLeft('NAME', 'Alex Johnson'),
                    const SizedBox(height: 16),
                    _buildDetailRowLeft('USER ID', 'HM-2024-X89-AH'),
                    const SizedBox(height: 16),
                    _buildDetailRowLeft('SOCIETY', 'Green Valley'),
                    const SizedBox(height: 16),
                    _buildDetailRowLeft('HOUSE NO', 'B-402'),
                    const SizedBox(height: 16),
                    _buildDetailRowLeft('PLOT NO', '98A'),
                    const SizedBox(height: 16),
                    _buildDetailRowLeft('ADDRESS', '123, Skyline Apartments, Near Central Park, Sector 45'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Secondary Links
              _buildLinkItem(CupertinoIcons.creditcard, 'Manage Payment'),
              const SizedBox(height: 12),
              _buildLinkItem(CupertinoIcons.settings, 'Setting'),
              const SizedBox(height: 12),
              _buildLinkItem(CupertinoIcons.info_circle, 'About'),
              const SizedBox(height: 32),
              // Logout Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Logout logic
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.arrow_right_square, color: CupertinoColors.destructiveRed),
                      const SizedBox(width: 8),
                      Text('Logout', style: AppTextStyles.body.copyWith(color: CupertinoColors.destructiveRed, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPillButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.actionBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: AppTextStyles.subtext.copyWith(color: AppColors.actionBlue, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildPlanCard(BuildContext context, String name, String? description, bool isActive, SubscriptionTier tier) {
    IconData planIcon;
    Color iconColor;
    
    if (name == 'Silver') {
      planIcon = CupertinoIcons.tag_fill;
      iconColor = CupertinoColors.systemGrey;
    } else if (name == 'Gold') {
      planIcon = CupertinoIcons.star_fill;
      iconColor = CupertinoColors.systemYellow;
    } else {
      planIcon = CupertinoIcons.star_fill;
      iconColor = AppColors.actionBlue;
    }

    return GestureDetector(
      onTap: () {
        AppNavigator.pushPlanDetail(context, tier);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? AppColors.actionBlue : AppColors.border, width: isActive ? 2 : 1),
          boxShadow: isActive ? [
            BoxShadow(
              color: AppColors.actionBlue.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          children: [
            Icon(planIcon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: AppTextStyles.header),
                      if (isActive) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.successGreen,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('ACTIVE', style: AppTextStyles.subtext.copyWith(color: CupertinoColors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(description, style: AppTextStyles.subtext),
                    ),
                ],
              ),
            ),
            Icon(CupertinoIcons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  /// Hard-coded left-aligned row for Profile Details - label and value both left.
  Widget _buildDetailRowLeft(String label, String value) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.subtext.copyWith(
              color: AppColors.textPlaceholder,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.body.copyWith(fontSize: 14),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.actionBlue),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppTextStyles.body)),
          Icon(CupertinoIcons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
