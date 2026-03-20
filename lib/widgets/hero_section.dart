import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();

    return Container(
      key: keys.homeKey,
      width: double.infinity,
      height: 760,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/1920/1200?grayscale'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.52),
              Colors.black.withValues(alpha: 0.78),
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppContent.realtorName} • ${AppContent.role}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Luxury Service.\nLocal Expertise.\nTrusted Results.',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: MediaQuery.of(context).size.width < 600 ? 40 : 62,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 40,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText(
                          AppContent.tagline,
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          duration: const Duration(milliseconds: 1800),
                        ),
                        FadeAnimatedText(
                          'Serving Fairfax and Northern Virginia',
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          duration: const Duration(milliseconds: 1800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      ElevatedButton(
                        onPressed: () => keys.scrollToSection('listings'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                            vertical: AppSpacing.md,
                          ),
                        ),
                        child: const Text('View Listings'),
                      ),
                      OutlinedButton(
                        onPressed: () => keys.scrollToSection('contact'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                            vertical: AppSpacing.md,
                          ),
                        ),
                        child: const Text('Contact Me'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
