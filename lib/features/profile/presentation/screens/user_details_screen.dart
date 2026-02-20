import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../shared/widgets/app_button.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _societyController;
  late final TextEditingController _houseNoController;
  late final TextEditingController _plotNoController;
  late final TextEditingController _userIdController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: 'Alex Johnson');
    _addressController = TextEditingController(text: '123, Skyline Apartments, Near Central Park, Sector 45');
    _societyController = TextEditingController(text: 'Green Valley');
    _houseNoController = TextEditingController(text: 'B-402');
    _plotNoController = TextEditingController(text: '98A');
    _userIdController = TextEditingController(text: 'HM-2024-X89');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _societyController.dispose();
    _houseNoController.dispose();
    _plotNoController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoPageScaffold(
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
              padding: const EdgeInsets.only(bottom: 100), // Space for bottom nav
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
              // Avatar with Edit - Blue camera icon
              Center(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFDE8E8), // Light pink/peach background
                      ),
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CupertinoColors.systemGrey5,
                          image: const DecorationImage(
                            image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.actionBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.camera_fill, color: CupertinoColors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('Alex Johnson', style: AppTextStyles.title),
              Text('Premium Member', style: AppTextStyles.subtext),
              const SizedBox(height: 32),
              // Form - Multi-line address box and individual inputs
              _buildLabeledInput('FULL NAME', _fullNameController),
              const SizedBox(height: 16),
              _buildLabeledInput('ADDRESS', _addressController, maxLines: 3),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildLabeledInput('SOCIETY NAME', _societyController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildLabeledInput('HOUSE NO.', _houseNoController)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildLabeledInput('PLOT NO.', _plotNoController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildLabeledInput('USER ID', _userIdController, readOnly: true)),
                ],
              ),
              const SizedBox(height: 32),
              // Sticky "Save Changes" blue button
              AppButton(
                text: 'Save Changes',
                onPressed: () {},
                prefixIcon: const Icon(CupertinoIcons.check_mark, color: CupertinoColors.white),
              ),
              const SizedBox(height: 16),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  AppNavigator.pushSubscriptionPlans(context);
                },
                child: Text(
                  'View Plans',
                  style: AppTextStyles.body.copyWith(color: AppColors.actionBlue),
                ),
              ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Bottom Navigation Bar
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
                  color: CupertinoColors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.home, color: CupertinoColors.systemGrey),
                          const SizedBox(height: 4),
                          Text(
                            'Service',
                            style: TextStyle(fontSize: 10, color: CupertinoColors.systemGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.actionBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.actionBlue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        AppNavigator.pushInventoryInstruction(context);
                      },
                      child: const Icon(CupertinoIcons.add, color: CupertinoColors.white, size: 32),
                    ),
                  ),
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.person, color: AppColors.actionBlue),
                          const SizedBox(height: 4),
                          Text(
                            'Account',
                            style: TextStyle(fontSize: 10, color: AppColors.actionBlue, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabeledInput(String label, TextEditingController controller, {int maxLines = 1, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.subtext.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.textPlaceholder,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CupertinoTextField(
            controller: controller,
            placeholder: '',
            readOnly: readOnly,
            maxLines: maxLines,
            decoration: null,
            style: AppTextStyles.body,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ],
    );
  }
}
