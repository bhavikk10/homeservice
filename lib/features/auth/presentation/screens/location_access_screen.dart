import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../shared/widgets/app_button.dart';

class LocationAccessScreen extends ConsumerWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // Skip - Navigate to Asset Inventory
            AppNavigator.pushInventoryInstruction(context);
          },
          child: Text(
            'Skip',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              // Map pin graphic with concentric circles
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer circle
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.actionBlue.withOpacity(0.1),
                      ),
                    ),
                    // Middle circle
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.actionBlue.withOpacity(0.2),
                      ),
                    ),
                    // Inner circle with better location icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.actionBlue,
                      ),
                      child: const Icon(
                        CupertinoIcons.location_fill,
                        size: 48,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Location Access',
                style: AppTextStyles.display,
              ),
              const SizedBox(height: 16),
              Text(
                'Allow "Home" to access your location to find professional plumbers, electricians, and cleaners in your immediate area.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              _buildBenefitItem(
                icon: CupertinoIcons.location_solid,
                title: 'Precise Matching',
                subtitle: 'Connect with the closest available experts for immediate help.',
              ),
              const SizedBox(height: 24),
              _buildBenefitItem(
                icon: CupertinoIcons.map,
                title: 'Arrival Tracking',
                subtitle: 'See exactly when your pro will arrive with real-time updates.',
              ),
              const Spacer(),
              // Bottom-fixed blue "Grant Access" button
              AppButton(
                text: 'Grant Access',
                onPressed: () {
                  ref.read(authProvider.notifier).grantLocationAccess();
                  AppNavigator.pushInventoryInstruction(context);
                },
              ),
              const SizedBox(height: 16),
              Text(
                'You can manage permissions in your iOS Settings at any time.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtext,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem({required IconData icon, required String title, required String subtitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.actionBlue.withOpacity(0.1),
            shape: BoxShape.circle,
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
              Text(subtitle, style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}
