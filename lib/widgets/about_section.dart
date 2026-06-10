import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../main.dart';
import 'section_heading.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Widget _aboutRightColumn(BuildContext context) {
    return Column(
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
        const _PerformanceBand(),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'Recognition',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _RecognitionList(),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'FOLLOW ALONG',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 2.4,
                color: AppColors.primary,
              ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _AboutSocialRow(),
      ],
    );
  }

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
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                eyebrow: 'Meet your advisor',
                title: 'Experience that moves you forward.',
                description:
                    'Personal representation, informed strategy, and steady guidance from the first conversation to closing.',
              ),
              const SizedBox(height: AppSpacing.xxl),
              if (isMobile) ...[
                const _AboutLeftPanel(isMobile: true),
                const SizedBox(height: AppSpacing.xl),
                _aboutRightColumn(context),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: _AboutLeftPanel(isMobile: false),
                    ),
                    const SizedBox(width: AppSpacing.xl),
                    Expanded(
                      flex: 3,
                      child: _aboutRightColumn(context),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Left column: light editorial panel — portrait + “MEET [NAME]” (reference layout).
/// Circular-outline social icons (Ikon-style) for the About section.
class _AboutSocialRow extends StatelessWidget {
  const _AboutSocialRow();

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <({IconData icon, String url, String tooltip})>[
      (
        icon: FontAwesomeIcons.facebookF,
        url: AppContent.facebook,
        tooltip: 'Facebook'
      ),
      (
        icon: FontAwesomeIcons.instagram,
        url: AppContent.instagram,
        tooltip: 'Instagram'
      ),
      (
        icon: FontAwesomeIcons.linkedinIn,
        url: AppContent.linkedIn,
        tooltip: 'LinkedIn'
      ),
      (
        icon: FontAwesomeIcons.whatsapp,
        url: AppContent.whatsapp,
        tooltip: 'WhatsApp'
      ),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final item in items)
          Tooltip(
            message: item.tooltip,
            child: _SocialCircleButton(
              icon: item.icon,
              onTap: () => _open(item.url),
            ),
          ),
      ],
    );
  }
}

class _SocialCircleButton extends StatelessWidget {
  const _SocialCircleButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.85), width: 1.4),
          ),
          alignment: Alignment.center,
          child: FaIcon(icon, size: 18, color: AppColors.primary),
        ),
      ),
    );
  }
}

class _AboutLeftPanel extends StatelessWidget {
  const _AboutLeftPanel({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0ECE3),
        borderRadius: BorderRadius.circular(2),
      ),
      padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: Image.asset(
                AppContent.aboutAgentPortraitAsset,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                filterQuality: FilterQuality.high,
                errorBuilder: (_, __, ___) => Image.network(
                  'https://picsum.photos/640/853?portrait',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
          Text(
            AppContent.aboutMeetHeadline,
            style: GoogleFonts.montserrat(
              fontSize: isMobile ? 27 : 38,
              fontWeight: FontWeight.w500,
              letterSpacing: 3.2,
              height: 1.05,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceBand extends StatelessWidget {
  const _PerformanceBand();

  static const _stats = [
    _PerformanceStat(value: '278', label: 'Closed Sales'),
    _PerformanceStat(value: '169.2M', label: 'Total Sales Volume'),
    _PerformanceStat(value: '382.5K – 2.2M', label: 'Price Range'),
    _PerformanceStat(value: '608.7K', label: 'Average Sale Price'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 480 ? 1 : 4;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'PERFORMANCE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontSize: 11,
                        letterSpacing: 1.8,
                      ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(child: Divider(color: AppColors.divider)),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'PRIOR 5 YEARS',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _stats.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisExtent: columns == 1 ? 102 : 108,
              ),
              itemBuilder: (context, index) {
                final isLastInRow =
                    (index + 1) % columns == 0 || index == _stats.length - 1;
                final hasRowBelow = index + columns < _stats.length;

                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: isLastInRow
                          ? BorderSide.none
                          : const BorderSide(color: AppColors.divider),
                      bottom: hasRowBelow
                          ? const BorderSide(color: AppColors.divider)
                          : BorderSide.none,
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: index % columns == 0 ? 0 : AppSpacing.sm,
                    right: isLastInRow ? 0 : AppSpacing.sm,
                    top: AppSpacing.sm,
                    bottom: AppSpacing.sm,
                  ),
                  child: _StatItem(stat: _stats[index]),
                );
              },
            ),
            const Divider(color: AppColors.divider),
          ],
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.stat});

  final _PerformanceStat stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            stat.value,
            maxLines: 1,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          stat.label,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textPrimary,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}

class _PerformanceStat {
  const _PerformanceStat({required this.value, required this.label});

  final String value;
  final String label;
}

class _RecognitionList extends StatelessWidget {
  const _RecognitionList();

  @override
  Widget build(BuildContext context) {
    const items = [
      'Top 5% Top Agent Award Winner by Homesnap',
      'Top 1% Producing Agent in USA',
      'NVAR Top Producer Platinum Club (2021, 2022, 2023, 2024)',
      '#1 Agent Ikon Realty (2021, 2022, 2023, 2024)',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final text in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: FaIcon(
                    FontAwesomeIcons.certificate,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
