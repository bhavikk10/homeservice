import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../shared/widgets/app_button.dart';

class ScanningResultsScreen extends StatelessWidget {
  const ScanningResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text('Your Covered Assets', style: AppTextStyles.title),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Preview - Top video thumbnail titled Home_Walkthrough.mp4 (2:45 duration)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: CupertinoColors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Placeholder for video
                  Icon(CupertinoIcons.play_circle_fill, color: CupertinoColors.white.withOpacity(0.8), size: 48),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(CupertinoIcons.videocam_fill, color: AppColors.actionBlue, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Home_Walkthrough.mp4',
                    style: AppTextStyles.header,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text('02:45', style: AppTextStyles.subtext),
              ],
            ),
            const SizedBox(height: 24),
            // Info Box - Light blue information bubble
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.actionBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.actionBlue.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.info, color: AppColors.actionBlue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "We've identified the following items. An executive will verify these during your first audit visit.",
                      style: AppTextStyles.subtext.copyWith(color: AppColors.actionBlue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('IDENTIFIED ITEMS (4)', style: AppTextStyles.subtext.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            _buildAssetItem(
              icon: CupertinoIcons.drop_fill,
              title: 'LG Refrigerator',
              subtitle: 'Kitchen Asset',
            ),
            const SizedBox(height: 12),
            _buildAssetItem(
              icon: CupertinoIcons.snow,
              title: 'Samsung Split AC',
              subtitle: 'Living Room Asset',
            ),
            const SizedBox(height: 12),
            _buildAssetItem(
              icon: CupertinoIcons.device_desktop,
              title: 'Sony Bravia 55"',
              subtitle: 'Living Room Asset',
            ),
            const SizedBox(height: 12),
            _buildAssetItem(
              icon: CupertinoIcons.drop_fill,
              title: 'Kitchen Faucet',
              subtitle: 'Kitchen Asset',
            ),
            const SizedBox(height: 24),
            // Floating "+ Add Missing Item" text
            Center(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // Add missing item logic
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.actionBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.add, color: AppColors.actionBlue, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Add Missing Item',
                        style: AppTextStyles.header.copyWith(color: AppColors.actionBlue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // "Submit Profile" blue button
            AppButton(
              text: 'Submit Profile',
              onPressed: () {
                AppNavigator.replaceWithMain(context);
              },
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildAssetItem({required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
             padding: const EdgeInsets.all(10),
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
                Text(subtitle, style: AppTextStyles.subtext),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.warningGold,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'PENDING AUDIT',
              style: AppTextStyles.subtext.copyWith(
                color: AppColors.warningText,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
