import 'package:flutter/cupertino.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? prefixIcon;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 56, // Standard height
      child: CupertinoButton(
        onPressed: isLoading ? null : onPressed,
        color: backgroundColor ?? AppColors.actionBlue,
        borderRadius: BorderRadius.circular(16),
        padding: EdgeInsets.zero,
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CupertinoActivityIndicator(
                  color: CupertinoColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.button.copyWith(
                      color: textColor ?? CupertinoColors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
