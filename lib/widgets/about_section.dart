import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../main.dart';

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
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: AppSpacing.xl),
              if (isMobile) ...[
                const _AboutLeftPanel(isMobile: true),
                const SizedBox(height: AppSpacing.xl),
                _aboutRightColumn(context),
              ] else
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
      (icon: FontAwesomeIcons.facebookF, url: AppContent.facebook, tooltip: 'Facebook'),
      (icon: FontAwesomeIcons.instagram, url: AppContent.instagram, tooltip: 'Instagram'),
      (icon: FontAwesomeIcons.linkedinIn, url: AppContent.linkedIn, tooltip: 'LinkedIn'),
      (icon: FontAwesomeIcons.whatsapp, url: AppContent.whatsapp, tooltip: 'WhatsApp'),
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
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.85), width: 1.4),
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
      color: Colors.white,
      padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
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
              fontSize: isMobile ? 28 : 40,
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
