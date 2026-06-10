import 'package:flutter/material.dart';

import '../constants.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.description,
    this.centered = false,
  });

  final String eyebrow;
  final String title;
  final String? description;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final alignment =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 28, height: 1, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(
              eyebrow.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                    fontSize: 12,
                    letterSpacing: 2.1,
                  ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          title,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: MediaQuery.sizeOf(context).width < 600 ? 38 : 48,
              ),
        ),
        if (description != null) ...[
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              description!,
              textAlign: centered ? TextAlign.center : TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}
