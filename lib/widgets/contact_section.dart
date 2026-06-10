import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../main.dart';
import 'map_embed.dart';
import 'section_heading.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _launchLink(String value) async {
    final uri = Uri.parse(value);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keys = context.read<ScrollSectionController>();
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      key: keys.contactKey,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.section),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                eyebrow: 'Let’s connect',
                title: 'Your next move starts here.',
                description:
                    'Tell me what you are planning. I’ll follow up with clear next steps and local insight.',
              ),
              const SizedBox(height: AppSpacing.xxl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.16),
                      AppColors.card,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.32),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.14),
                      ),
                      child: const Icon(
                        Icons.home_work_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Curious what your home is worth?',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Get a complimentary market valuation for your DMV property.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    if (!isMobile) ...[
                      const SizedBox(width: AppSpacing.lg),
                      OutlinedButton(
                        onPressed: () => _launchLink(AppContent.website),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                          foregroundColor: AppColors.textPrimary,
                        ),
                        child: const Text('Request Valuation'),
                      ),
                    ],
                  ],
                ),
              ),
              if (isMobile) ...[
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _launchLink(AppContent.website),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      foregroundColor: AppColors.textPrimary,
                    ),
                    child: const Text('Request Valuation'),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              if (isMobile) ...[
                _ContactFormCard(
                  formKey: _formKey,
                  name: _name,
                  email: _email,
                  phone: _phone,
                  message: _message,
                  stretchMessageField: false,
                ),
                const SizedBox(height: AppSpacing.md),
                _ContactInfoCard(launchLink: _launchLink),
              ] else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _ContactFormCard(
                          formKey: _formKey,
                          name: _name,
                          email: _email,
                          phone: _phone,
                          message: _message,
                          stretchMessageField: true,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _ContactInfoCard(launchLink: _launchLink),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactFormCard extends StatelessWidget {
  const _ContactFormCard({
    required this.formKey,
    required this.name,
    required this.email,
    required this.phone,
    required this.message,
    required this.stretchMessageField,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController message;
  final bool stretchMessageField;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize:
                stretchMessageField ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Text(
                'Send a message',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    v == null || !v.contains('@') ? 'Enter valid email' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: phone,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: AppSpacing.md),
              if (stretchMessageField)
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      alignLabelWithHint: true,
                    ),
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                  ),
                )
              else
                TextFormField(
                  controller: message,
                  decoration: const InputDecoration(labelText: 'Message'),
                  maxLines: 4,
                ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Message submitted successfully.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Send Message'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  const _ContactInfoCard({required this.launchLink});

  final Future<void> Function(String value) launchLink;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${AppContent.realtorName} • ${AppContent.company}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
                '${AppContent.addressLine1}\n${AppContent.addressLine2}'),
            const SizedBox(height: AppSpacing.sm),
            _ContactItem(
              icon: FontAwesomeIcons.phone,
              label: 'Cell: ${AppContent.phoneCell}',
              onTap: () => launchLink('tel:+17038692665'),
            ),
            _ContactItem(
              icon: FontAwesomeIcons.building,
              label: 'Office: ${AppContent.phoneOffice}',
              onTap: () => launchLink('tel:+17036583999'),
            ),
            _ContactItem(
              icon: FontAwesomeIcons.envelope,
              label: AppContent.email,
              onTap: () => launchLink('mailto:${AppContent.email}'),
            ),
            _ContactItem(
              icon: FontAwesomeIcons.globe,
              label: AppContent.website,
              onTap: () => launchLink(AppContent.website),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(AppContent.workingHours),
            const SizedBox(height: AppSpacing.lg),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const SizedBox(
                height: 260,
                width: double.infinity,
                child: MapEmbed(
                  embedUrl:
                      'https://www.google.com/maps?q=3554+Chain+Bridge+Road+Suite+305+Fairfax+VA+22030&output=embed',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            FaIcon(icon, size: 14, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
