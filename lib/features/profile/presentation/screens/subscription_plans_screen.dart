import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text('Plan Comparison', style: AppTextStyles.title),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select the best maintenance tier for your property.', style: AppTextStyles.subtext),
              const SizedBox(height: 24),
              // Plan Cards - Horizontal selection for Silver, Gold, Diamond
              SizedBox(
                height: 380,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  children: [
                    _buildPlanCard(
                      'Current',
                      'Silver',
                      [
                        'Home Video Reporting',
                        'Periodic Inspections',
                      ],
                      isActive: true,
                    ),
                    const SizedBox(width: 16),
                    _buildPlanCard(
                      'Recommended',
                      'Gold',
                      [
                        'Home Video Reporting',
                        'Periodic Inspections',
                        'All Items Maintenance',
                      ],
                      isActive: false,
                    ),
                    const SizedBox(width: 16),
                    _buildPlanCard(
                      'Premium',
                      'Diamond',
                      [
                        'Home Video Reporting',
                        'Periodic Inspections',
                        'All Items Maintenance',
                        'Priority Support',
                      ],
                      isActive: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('Feature Breakdown', style: AppTextStyles.header),
              const SizedBox(height: 16),
              // Feature Breakdown table with checkmarks (S, G, D)
              _buildFeatureTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(
    String tagline,
    String title,
    List<String> features, {
    bool isActive = false,
  }) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? AppColors.actionBlue : AppColors.border,
          width: isActive ? 2 : 1,
        ),
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
              Text(title, style: AppTextStyles.title.copyWith(fontSize: 24)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.actionBlue : AppColors.warningGold,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  isActive ? 'CURRENT' : tagline.toUpperCase(),
                  style: AppTextStyles.subtext.copyWith(
                    color: isActive ? CupertinoColors.white : AppColors.warningText,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                const Icon(CupertinoIcons.check_mark_circled_solid, color: AppColors.actionBlue, size: 20),
                const SizedBox(width: 8),
                Expanded(child: Text(f, style: AppTextStyles.body)),
              ],
            ),
          )),
          const Spacer(),
          AppButton(
            text: isActive ? 'Active Plan' : 'Upgrade',
            onPressed: () {},
            backgroundColor: isActive ? AppColors.backgroundLight : AppColors.actionBlue,
            textColor: isActive ? AppColors.actionBlue : CupertinoColors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTable() {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('FEATURE', style: AppTextStyles.subtext.copyWith(fontWeight: FontWeight.bold, color: AppColors.actionBlue)),
                ),
                Expanded(child: Center(child: Text('S', style: AppTextStyles.subtext.copyWith(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('G', style: AppTextStyles.subtext.copyWith(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text('D', style: AppTextStyles.subtext.copyWith(fontWeight: FontWeight.bold)))),
              ],
            ),
          ),
          _buildTableRow('Home Video Reporting', true, true, true),
          _buildTableRow('Periodic Inspections', true, true, true),
          _buildTableRow('All Items Maintenance', false, true, true),
          _buildTableRow('Priority Support', false, false, true),
        ],
      ),
    );
  }

  Widget _buildTableRow(String feature, bool s, bool g, bool d) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(feature, style: AppTextStyles.body),
          ),
          Expanded(
            child: Center(
              child: Icon(
                s ? CupertinoIcons.check_mark : CupertinoIcons.xmark,
                size: 16,
                color: s ? AppColors.actionBlue : CupertinoColors.systemGrey3,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Icon(
                g ? CupertinoIcons.check_mark : CupertinoIcons.xmark,
                size: 16,
                color: g ? AppColors.actionBlue : CupertinoColors.systemGrey3,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Icon(
                d ? CupertinoIcons.check_mark : CupertinoIcons.xmark,
                size: 16,
                color: d ? AppColors.actionBlue : CupertinoColors.systemGrey3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
