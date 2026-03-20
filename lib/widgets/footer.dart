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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Wrap(
            runSpacing: AppSpacing.lg,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppContent.realtorName} • ${AppContent.company}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(AppContent.tagline),
                ],
              ),
              Wrap(
                spacing: AppSpacing.md,
                children: [
                  _FooterLink('Home', () => sc.scrollToSection('home')),
                  _FooterLink('About', () => sc.scrollToSection('about')),
                  _FooterLink('Listings', () => sc.scrollToSection('listings')),
                  _FooterLink('Services', () => sc.scrollToSection('services')),
                  _FooterLink('Contact', () => sc.scrollToSection('contact')),
                ],
              ),
              Text(
                '© ${DateTime.now().year} ${AppContent.company}. All Rights Reserved.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'All information is deemed reliable but not guaranteed and should be independently reviewed and verified.',
                style: Theme.of(context).textTheme.bodyMedium,
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
