import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../shared/widgets/app_button.dart';

class CaptureProblemScreen extends StatefulWidget {
  const CaptureProblemScreen({super.key});

  @override
  State<CaptureProblemScreen> createState() => _CaptureProblemScreenState();
}

class _CaptureProblemScreenState extends State<CaptureProblemScreen> {
  late final TextEditingController _problemDescriptionController;

  @override
  void initState() {
    super.initState();
    _problemDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _problemDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text('Review & Describe', style: AppTextStyles.title),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator
              Text('STEP 2 OF 2', style: AppTextStyles.subtext.copyWith(fontWeight: FontWeight.w600, color: AppColors.actionBlue)),
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 2,
                color: AppColors.actionBlue,
              ),
              const SizedBox(height: 24),
              Text('Review & Describe', style: AppTextStyles.display),
              const SizedBox(height: 24),
              // Video Preview 1:1 aspect ratio
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(CupertinoIcons.play_circle_fill, color: CupertinoColors.white.withOpacity(0.8), size: 64),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // Retake video logic
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: CupertinoColors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(CupertinoIcons.arrow_clockwise, size: 16, color: AppColors.actionBlue),
                                const SizedBox(width: 4),
                                Text(
                                  'Retake',
                                  style: AppTextStyles.subtext.copyWith(
                                    color: AppColors.actionBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: CupertinoColors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('0:12', style: AppTextStyles.subtext.copyWith(color: CupertinoColors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('DESCRIBE YOUR PROBLEM IN DETAIL', style: AppTextStyles.subtext.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CupertinoTextField(
                      controller: _problemDescriptionController,
                      maxLines: 5,
                      maxLength: 500,
                      placeholder: 'e.g. The kitchen sink is leaking from the main pipe and causing a small puddle under the cabinet...',
                      placeholderStyle: AppTextStyles.body.copyWith(color: AppColors.textPlaceholder),
                      style: AppTextStyles.body,
                      decoration: null,
                      padding: EdgeInsets.zero,
                      onChanged: (value) {
                        setState(() {}); // Update counter
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_problemDescriptionController.text.length}/500',
                      style: AppTextStyles.subtext.copyWith(color: AppColors.textPlaceholder),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              AppButton(
                text: 'Submit Request >>',
                onPressed: () {
                  AppNavigator.pushTrackingTimeline(context);
                },
              ),
              const SizedBox(height: 16),
              Text(
                'By submitting, a maintenance professional will review your request and contact you shortly.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
