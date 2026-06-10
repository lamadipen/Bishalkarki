import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../main.dart';
import 'section_heading.dart';

Future<void> launchListingUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class ListingsSection extends StatelessWidget {
  const ListingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();
    final isMobile = MediaQuery.sizeOf(context).width < 760;

    return Container(
      key: keys.listingsKey,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.section,
      ),
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'Always current',
                title: 'Explore the live property portfolio.',
                description:
                    'Active listings, open houses, and recent sales are maintained on Bishal’s verified Homes.com profile.',
                centered: true,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        AppContent.heroAsset,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withValues(alpha: 0.96),
                              Colors.black.withValues(alpha: 0.84),
                              Colors.black.withValues(alpha: 0.54),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                        isMobile ? AppSpacing.lg : AppSpacing.xxl,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.4),
                              ),
                            ),
                            child: const Text(
                              'LIVE ON HOMES.COM',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 590),
                            child: Text(
                              'See what is available right now.',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontSize: isMobile ? 32 : 42),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 590),
                            child: Text(
                              'For more listings, photos, pricing, and open-house information, visit the listing page.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          const Wrap(
                            spacing: AppSpacing.md,
                            runSpacing: AppSpacing.md,
                            children: [
                              _PortfolioFeature(
                                icon: Icons.home_work_outlined,
                                label: 'Active Listings',
                              ),
                              _PortfolioFeature(
                                icon: Icons.event_available_outlined,
                                label: 'Open Houses',
                              ),
                              _PortfolioFeature(
                                icon: Icons.insights_outlined,
                                label: 'Recent Sales',
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          ElevatedButton.icon(
                            onPressed: () => launchListingUrl(
                              AppContent.homesAgentListingsUrl,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.black,
                            ),
                            icon: const Icon(Icons.open_in_new, size: 18),
                            label: const Text('View Live Listings'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Property availability and details are provided and updated by Homes.com.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary.withValues(alpha: 0.78),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortfolioFeature extends StatelessWidget {
  const _PortfolioFeature({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 13,
                ),
          ),
        ],
      ),
    );
  }
}
