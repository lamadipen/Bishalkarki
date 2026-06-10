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
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;

    return Container(
      key: keys.homeKey,
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 680 : 780),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppContent.heroAsset),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withValues(alpha: 0.88),
              Colors.black.withValues(alpha: 0.58),
              Colors.black.withValues(alpha: 0.28),
            ],
            stops: const [0, 0.52, 1],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      'NORTHERN VIRGINIA  •  REAL ESTATE',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.primary,
                            fontSize: 11,
                            letterSpacing: 1.8,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Text(
                      'Move with clarity.\nLive with confidence.',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: isMobile ? 46 : 72,
                            letterSpacing: -1.6,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 610),
                    child: Text(
                      'Strategic guidance for buyers, sellers, and investors across the DMV.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:
                                AppColors.textPrimary.withValues(alpha: 0.86),
                            fontSize: isMobile ? 17 : 20,
                            height: 1.5,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 30,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText(
                          AppContent.tagline,
                          textStyle:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                          duration: const Duration(milliseconds: 2200),
                        ),
                        FadeAnimatedText(
                          'Local expertise. Personal attention.',
                          textStyle:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.primary,
                                  ),
                          duration: const Duration(milliseconds: 2200),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      ElevatedButton(
                        onPressed: () => keys.scrollToSection('listings'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Explore Listings'),
                      ),
                      OutlinedButton(
                        onPressed: () => keys.scrollToSection('contact'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          foregroundColor: AppColors.textPrimary,
                        ),
                        child: const Text('Start a Conversation'),
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
