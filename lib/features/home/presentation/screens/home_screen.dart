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
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.actionBlue.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
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
                            boxShadow: [
                              BoxShadow(
                                color: CupertinoColors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
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
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon) {
    // Network placeholder images - visible when assets are missing
    final serviceImages = <String, String>{
      'Electrician': 'https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=400',
      'Plumber': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400',
      'Carpenter': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'Dry Cleaning': 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=400',
      'Pest Control': 'https://media.istockphoto.com/id/486726853/photo/ironing-with-garment-steamer.jpg?s=612x612&w=0&k=20&c=t8NvfBAcpD3fb7iQfsEZRfh9YT1txiFR9aAJTJORy3o=',
      'Cleaning': 'https://static.vecteezy.com/system/resources/thumbnails/074/448/133/small/a-woman-in-yellow-gloves-cleans-the-kitchen-counter-with-a-yellow-cloth-showcasing-a-bright-and-tidy-atmosphere-photo.jpeg',
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
      child: _AnimatedServiceCard(
        onTap: () {
          AppNavigator.pushServiceDetail(context, title);
        },
        icon: icon,
        title: title,
        serviceImages: serviceImages,
      ),
    );
  }
}

class _AnimatedServiceCard extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final Map<String, String> serviceImages;

  const _AnimatedServiceCard({
    required this.onTap,
    required this.icon,
    required this.title,
    required this.serviceImages,
  });

  @override
  State<_AnimatedServiceCard> createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<_AnimatedServiceCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
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
                child: widget.serviceImages.containsKey(widget.title)
                    ? Image.network(
                        widget.serviceImages[widget.title]!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: const Color(0xFFEEF2FF),
                            child: Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.actionBlue,
                                radius: 12,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFEEF2FF),
                            child: Icon(widget.icon, color: AppColors.actionBlue, size: 32),
                          );
                        },
                      )
                    : Container(
                        color: const Color(0xFFEEF2FF),
                        child: Icon(widget.icon, color: AppColors.actionBlue, size: 32),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(widget.title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
      ),
    );
  }

}
