import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {
            context.push('/asset-inventory-instruction');
          },
          backgroundColor: AppColors.actionBlue,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _goBranch(0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home,
                        color: navigationShell.currentIndex == 0
                            ? AppColors.actionBlue
                            : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Service',
                        style: TextStyle(
                          fontSize: 10,
                          color: navigationShell.currentIndex == 0
                              ? AppColors.actionBlue
                              : Colors.grey,
                          fontWeight: navigationShell.currentIndex == 0
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 48),
              Expanded(
                child: InkWell(
                  onTap: () => _goBranch(1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        color: navigationShell.currentIndex == 1
                            ? AppColors.actionBlue
                            : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 10,
                          color: navigationShell.currentIndex == 1
                              ? AppColors.actionBlue
                              : Colors.grey,
                          fontWeight: navigationShell.currentIndex == 1
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
