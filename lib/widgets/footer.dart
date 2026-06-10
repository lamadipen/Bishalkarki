import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sc = context.read<ScrollSectionController>();

    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppSpacing.xxl,
                runSpacing: AppSpacing.lg,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppContent.realtorName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 30),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          '${AppContent.company} • ${AppContent.tagline}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.xs,
                    children: [
                      _FooterLink('Home', () => sc.scrollToSection('home')),
                      _FooterLink('About', () => sc.scrollToSection('about')),
                      _FooterLink(
                        'Listings',
                        () => sc.scrollToSection('listings'),
                      ),
                      _FooterLink(
                        'Services',
                        () => sc.scrollToSection('services'),
                      ),
                      _FooterLink(
                          'Contact', () => sc.scrollToSection('contact')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              const Divider(color: AppColors.divider),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.xxl,
                runSpacing: AppSpacing.sm,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Text(
                    '© ${DateTime.now().year} ${AppContent.company}. All rights reserved.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 12),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'Information is deemed reliable but not guaranteed and should be independently verified.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink(this.title, this.onTap);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onTap, child: Text(title));
  }
}
