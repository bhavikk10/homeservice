import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100), // Extra padding for bottom nav
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar - Rounded gray bar with "Search services..."
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CupertinoTextField(
                    placeholder: 'Search services...',
                    placeholderStyle: AppTextStyles.body.copyWith(color: AppColors.textPlaceholder),
                    prefix: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(CupertinoIcons.search, color: AppColors.textPlaceholder),
                    ),
                    decoration: null,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 24),
                // Banner - Gradient blue card: "Professional Maintenance at Your Doorstep" with "Book Now" pill
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A56DB), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Professional\nMaintenance at\nYour Doorstep',
                        style: AppTextStyles.title.copyWith(color: CupertinoColors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          // Navigate to service booking
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Book Now',
                            style: AppTextStyles.subtext.copyWith(
                              color: AppColors.actionBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Service Grid - 2-column grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Our Services', style: AppTextStyles.title.copyWith(fontSize: 18)),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // View all services
                      },
                      child: Text(
                        'View All',
                        style: AppTextStyles.subtext.copyWith(color: AppColors.actionBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildServiceCard(context, 'Electrician', CupertinoIcons.bolt_fill),
                    _buildServiceCard(context, 'Plumber', CupertinoIcons.drop_fill),
                    _buildServiceCard(context, 'Carpenter', CupertinoIcons.hammer_fill),
                    _buildServiceCard(context, 'Dry Cleaning', CupertinoIcons.drop_triangle_fill),
                    _buildServiceCard(context, 'Pest Control', CupertinoIcons.ant),
                    _buildServiceCard(context, 'Cleaning', CupertinoIcons.sparkles),
                  ],
                ),
                const SizedBox(height: 24),
                // Home Guarantee - Dark blue card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark Navy
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.check_mark_circled_solid, color: CupertinoColors.white, size: 20),
                          const SizedBox(width: 8),
                          Text('Home Guarantee', style: AppTextStyles.header.copyWith(color: CupertinoColors.white)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildGuaranteeItem(CupertinoIcons.check_mark_circled_solid, 'Service Warranty', 'Up to 30 days coverage'),
                      const SizedBox(height: 12),
                      _buildGuaranteeItem(CupertinoIcons.person_fill, 'Expert Professionals', 'Background checked technicians'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon) {
    // Service images from assets/categories (electrician.jpg, plumber.webp, etc.)
    final serviceImages = {
      'Electrician': 'assets/categories/electrician.jpg',
      'Plumber': 'assets/categories/plumber.webp',
      'Carpenter': 'assets/categories/carpenter.png',
      'Dry Cleaning': 'assets/categories/dry_cleaning.jpg',
      'Pest Control': 'assets/categories/pest_control.jpg',
      'Cleaning': 'assets/categories/cleaning.webp',
    };

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value, child: child),
        );
      },
      child: GestureDetector(
        onTap: () {
          AppNavigator.pushServiceDetail(context, title);
        },
        child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: serviceImages.containsKey(title)
                    ? Image.asset(
                        serviceImages[title]!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFEEF2FF),
                            child: Icon(icon, color: AppColors.actionBlue, size: 32),
                          );
                        },
                      )
                    : Container(
                        color: const Color(0xFFEEF2FF),
                        child: Icon(icon, color: AppColors.actionBlue, size: 32),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildGuaranteeItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: CupertinoColors.systemBlue, size: 16),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.body.copyWith(color: CupertinoColors.white, fontSize: 13)),
            Text(subtitle, style: AppTextStyles.subtext.copyWith(color: CupertinoColors.white.withOpacity(0.7), fontSize: 11)),
          ],
        ),
      ],
    );
  }
}
