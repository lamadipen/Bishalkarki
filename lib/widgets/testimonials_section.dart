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
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: testimonials[index].imageUrl != null ? NetworkImage(testimonials[index].imageUrl!) : null,
                              child: testimonials[index].imageUrl == null ? const Icon(Icons.person) : null,
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
  const _Testimonial(this.name, this.quote, {this.imageUrl});
  final String name;
  final String quote;
  final String? imageUrl;
}
