import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();

    const testimonials = [
      _Testimonial(
        'A. Rahman',
        'Bishal was incredibly responsive and negotiated exactly what we needed. He made our purchase feel easy.',
      ),
      _Testimonial(
        'M. Peterson',
        'Professional, strategic, and truly caring. From staging advice to closing, every detail was covered.',
      ),
      _Testimonial(
        'J. Lewis',
        'He understands this market deeply. We sold above asking and moved into our dream home right on schedule.',
      ),
    ];

    return Container(
      key: keys.testimonialsKey,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.section),
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              Text('Testimonials', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: AppSpacing.xl),
              CarouselSlider.builder(
                itemCount: testimonials.length,
                options: CarouselOptions(
                  height: 280,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: MediaQuery.of(context).size.width < 700 ? 0.96 : 0.52,
                ),
                itemBuilder: (_, index, __) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (_) => const Icon(Icons.star, color: AppColors.primary, size: 20),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '"${testimonials[index].quote}"',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage('https://picsum.photos/100'),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(testimonials[index].name),
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
  const _Testimonial(this.name, this.quote);
  final String name;
  final String quote;
}
