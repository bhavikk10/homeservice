import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../shared/widgets/app_button.dart';

class InventoryInstructionScreen extends StatelessWidget {
  const InventoryInstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            AppNavigator.replaceWithMain(context);
          },
          child: Text(
            'Skip for now',
            style: AppTextStyles.body.copyWith(color: AppColors.actionBlue),
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Graphic Placeholder
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Abstract shapes imitating the screenshot
                    Positioned(
                      top: 40,
                      child: Container(
                        width: 120,
                        height: 180,
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
                      ),
                    ),
                    // Icons floating
                    Positioned(
                      left: 60,
                      top: 100,
                      child: _buildFloatingIcon(CupertinoIcons.drop_fill),
                    ),
                    Positioned(
                      right: 60,
                      top: 60,
                      child: _buildFloatingIcon(CupertinoIcons.snow),
                    ),
                    Positioned(
                      left: 60,
                      bottom: 80,
                      child: _buildFloatingIcon(CupertinoIcons.device_desktop),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Secure Your Home Inventory',
                style: AppTextStyles.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Take a quick video walkthrough of your house. Show us your ACs, Fridge, TV, and plumbing. We'll automatically log your covered assets.",
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              // Shared icon at Secure Your Home Inventory
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.actionBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.camera_fill,
                    color: AppColors.actionBlue,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Recording Tip Card - Floating "RECORDING TIP"
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.actionBlue.withOpacity(0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.actionBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'RECORDING TIP',
                        style: AppTextStyles.subtext.copyWith(
                          color: AppColors.actionBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Pause for 2 seconds on each appliance to ensure accurate identification.',
                        style: AppTextStyles.subtext.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                text: 'Start Video Walkthrough',
                onPressed: () {
                  AppNavigator.pushScanningResults(context);
                },
                prefixIcon: const Icon(CupertinoIcons.videocam_fill, color: CupertinoColors.white),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.actionBlue, size: 20),
    );
  }
}
