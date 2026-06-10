import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';
import 'section_heading.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();

    const testimonials = [
      _Testimonial(
        'Ganesh Basnet',
        'Highly recommend Bishal as a great realtor in DC metro area! Very responsive, knowledgeable, friendly - truly a pleasure to work with.',
        imageUrl: null,
      ),
      _Testimonial(
        'Bivek Dhakal',
        'Thank you so much Bishal Karki for all of your help in the purchase of our dream house. Because of your knowledge, hard work and passion we now have a place to call our own. Happy home! Much appreciated!',
        imageUrl: null,
      ),
      _Testimonial(
        'Riwaj Rimal',
        'Bishal is outstanding. His professionalism, market knowledge, and commitment after closing sets him apart. Highly recommend for a fantastic real estate experience if you are in DMV area.',
        imageUrl: null,
      ),
    ];

    return Container(
      key: keys.testimonialsKey,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.section),
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Client stories',
                title: 'Trusted beyond the closing table.',
                description:
                    'Straight from clients who trusted Bishal with one of life’s biggest decisions.',
                centered: true,
              ),
              const SizedBox(height: AppSpacing.xxl),
              CarouselSlider.builder(
                itemCount: testimonials.length,
                options: CarouselOptions(
                  height: MediaQuery.sizeOf(context).width < 700 ? 410 : 380,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  enlargeCenterPage: true,
                  enlargeFactor: 0.12,
                  viewportFraction:
                      MediaQuery.sizeOf(context).width < 700 ? 0.94 : 0.58,
                ),
                itemBuilder: (_, index, __) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.format_quote_rounded,
                          color: AppColors.primary,
                          size: 36,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          testimonials[index].quote,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: 17,
                                  ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.primary.withValues(alpha: 0.12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                testimonials[index].name.substring(0, 1),
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  testimonials[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text(
                                  'Verified client',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: List.generate(
                                5,
                                (_) => const Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primary,
                                  size: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Testimonial {
  const _Testimonial(this.name, this.quote, {this.imageUrl});
  final String name;
  final String quote;
  final String? imageUrl;
}
