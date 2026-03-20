import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600 ? 1 : (width < 1024 ? 2 : 3);

    const services = [
      _Service(FontAwesomeIcons.house, 'Home Buying',
          'End-to-end support, negotiations, and market insights for smart purchases.'),
      _Service(FontAwesomeIcons.key, 'Home Selling',
          'Strategic pricing, premium marketing, and buyer outreach that drives top value.'),
      _Service(FontAwesomeIcons.chartLine, 'Market Analysis',
          'Neighborhood trends, pricing movement, and absorption rates to guide decisions.'),
      _Service(FontAwesomeIcons.sackDollar, 'Property Valuation',
          'Accurate comps and positioning strategies to maximize outcomes.'),
      _Service(FontAwesomeIcons.building, 'Investment Properties',
          'Identify high-potential properties and improve return with data-driven guidance.'),
      _Service(FontAwesomeIcons.truckFast, 'Relocation Assistance',
          'Stress-free planning for local and long-distance moves with trusted partners.'),
    ];

    return Container(
      key: keys.servicesKey,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.section),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            children: [
              Text('Services', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: AppSpacing.xl),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: width < 600 ? 1.3 : 1.2,
                ),
                itemBuilder: (_, i) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FaIcon(services[i].icon, color: AppColors.primary, size: 24),
                        const SizedBox(height: AppSpacing.md),
                        Text(services[i].title, style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: AppSpacing.sm),
                        Text(services[i].description, style: Theme.of(context).textTheme.bodyMedium),
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

class _Service {
  const _Service(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String description;
}
