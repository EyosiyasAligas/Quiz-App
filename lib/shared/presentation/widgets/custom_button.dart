import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final Alignment? alignment;
  final String? customKey;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.onLongPressed,
    this.alignment,
    this.customKey,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(customKey ?? ''),
      alignment: alignment,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              ),
            if (isLoading) const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
