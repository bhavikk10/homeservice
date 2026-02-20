import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../shared/widgets/app_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              // Icon - Blue square with white house icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.actionBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  CupertinoIcons.house_fill,
                  color: CupertinoColors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 24),
              // Title - 24pt Bold
              Text(
                'Home',
                style: AppTextStyles.display,
              ),
              const SizedBox(height: 8),
              // Subtitle - 14pt Regular, Gray
              Text(
                'Premium Home Services',
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 48),
              // Input label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your mobile number to get started',
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 16),
              // Phone Input with Prefix - 12px radius
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      '+91',
                      style: AppTextStyles.title.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 1,
                      height: 24,
                      color: AppColors.border,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CupertinoTextField(
                        placeholder: '99992XXXXX',
                        placeholderStyle: AppTextStyles.subtext.copyWith(
                          fontSize: 16,
                          color: AppColors.textPlaceholder,
                        ),
                        keyboardType: TextInputType.phone,
                        style: AppTextStyles.title.copyWith(fontSize: 16),
                        decoration: null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Blue "Send OTP" button
              AppButton(
                text: 'Send OTP',
                onPressed: () {
                  AppNavigator.pushOtp(context);
                },
              ),
              const SizedBox(height: 24),
              // Footer - "SECURED BY SSL" in 10pt caps
              Text(
                'SECURED BY SSL',
                style: AppTextStyles.subtext.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              // Footer - Terms and Privacy
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.subtext,
                  children: [
                    const TextSpan(text: 'By signing in, you agree to our\n'),
                    TextSpan(
                      text: 'Terms of Service',
                      style: AppTextStyles.subtext.copyWith(
                        color: AppColors.actionBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(text: ' & '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: AppTextStyles.subtext.copyWith(
                        color: AppColors.actionBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
