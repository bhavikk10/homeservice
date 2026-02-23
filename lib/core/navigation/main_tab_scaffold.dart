import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/profile/presentation/screens/profile_dashboard_screen.dart';
import '../../core/navigation/app_navigator.dart';
import '../../core/theme/app_colors.dart';

class MainTabScaffold extends StatefulWidget {
  const MainTabScaffold({super.key});

  @override
  State<MainTabScaffold> createState() => _MainTabScaffoldState();
}

class _MainTabScaffoldState extends State<MainTabScaffold> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _addIconController;
  late Animation<double> _addIconScale;
  late Animation<double> _addIconGlow;

  @override
  void initState() {
    super.initState();
    _addIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _addIconScale = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _addIconController, curve: Curves.easeInOut),
    );
    _addIconGlow = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(parent: _addIconController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _addIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: const [
              HomeScreen(),
              HomeScreen(), // Placeholder for Add New
              ProfileDashboardScreen(),
            ],
          ),
          // Custom Bottom Navigation Bar with large center button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -3),
                  ),
                  BoxShadow(
                    color: CupertinoColors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Service Tab
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: _currentIndex == 0 ? 1.0 : 0.6,
                        duration: const Duration(milliseconds: 200),
                        child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() => _currentIndex = 0);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.home,
                              color: _currentIndex == 0 ? AppColors.actionBlue : CupertinoColors.systemGrey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Service',
                              style: TextStyle(
                                fontSize: 10,
                                color: _currentIndex == 0 ? AppColors.actionBlue : CupertinoColors.systemGrey,
                                fontWeight: _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                    // Large Add New Button in Center with pulse/glow effect
                    AnimatedBuilder(
                      animation: _addIconController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _addIconScale.value,
                          child: Container(
                            width: 64,
                            height: 64,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: AppColors.actionBlue,
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.actionBlue,
                                  AppColors.actionBlue.withOpacity(0.85),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.actionBlue.withOpacity(0.35 + _addIconGlow.value),
                                  blurRadius: 14,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: AppColors.actionBlue.withOpacity(0.15 + _addIconGlow.value * 0.15),
                                  blurRadius: 24,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                AppNavigator.pushAddItem(context);
                              },
                              child: const Icon(
                                CupertinoIcons.add,
                                color: CupertinoColors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Account Tab
                    Expanded(
                      child: AnimatedOpacity(
                        opacity: _currentIndex == 2 ? 1.0 : 0.6,
                        duration: const Duration(milliseconds: 200),
                        child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() => _currentIndex = 2);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.person,
                              color: _currentIndex == 2 ? AppColors.actionBlue : CupertinoColors.systemGrey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Account',
                              style: TextStyle(
                                fontSize: 10,
                                color: _currentIndex == 2 ? AppColors.actionBlue : CupertinoColors.systemGrey,
                                fontWeight: _currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
