import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();
    final isMobile = MediaQuery.of(context).size.width < 850;

    return Container(
      key: keys.aboutKey,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: AppSpacing.xl),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://picsum.photos/640/780?person',
                        fit: BoxFit.cover,
                        height: isMobile ? 340 : 460,
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 0 : AppSpacing.xl, height: isMobile ? 20 : 0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppContent.realtorName} is a client-first ${AppContent.role.toLowerCase()} at ${AppContent.company}.',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'With a reputation for strategic pricing, strong negotiation, and high-touch service, Bishal guides buyers, sellers, and investors through every step with confidence. His local market knowledge across Fairfax and nearby communities helps clients move quickly and smartly in competitive conditions.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        const Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.md,
                          children: [
                            _CounterCard(label: 'Years Experience', value: 11),
                            _CounterCard(label: 'Properties Sold', value: 285),
                            _CounterCard(label: 'Happy Clients', value: 340),
                            _CounterCard(label: 'Areas Covered', value: 18),
                          ],
                        ),
                      ],
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

class _CounterCard extends StatefulWidget {
  const _CounterCard({required this.label, required this.value});
  final String label;
  final int value;

  @override
  State<_CounterCard> createState() => _CounterCardState();
}

class _CounterCardState extends State<_CounterCard> {
  int _display = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 18), (t) {
      if (!mounted) return;
      if (_display >= widget.value) {
        _timer?.cancel();
        return;
      }
      setState(() {
        _display += widget.value < 50 ? 1 : 3;
        if (_display > widget.value) _display = widget.value;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$_display+',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(widget.label),
        ],
      ),
    );
  }
}
