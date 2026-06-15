import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Centered branded loading indicator.
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 38,
            width: 38,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.tealGreen,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}
