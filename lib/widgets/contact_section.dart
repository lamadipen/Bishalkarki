import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../main.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.section),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: AppSpacing.xl),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _name,
                                decoration: const InputDecoration(labelText: 'Full Name'),
                                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              TextFormField(
                                controller: _email,
                                decoration: const InputDecoration(labelText: 'Email'),
                                validator: (v) => v == null || !v.contains('@') ? 'Enter valid email' : null,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              TextFormField(
                                controller: _phone,
                                decoration: const InputDecoration(labelText: 'Phone'),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              TextFormField(
                                controller: _message,
                                decoration: const InputDecoration(labelText: 'Message'),
                                maxLines: 4,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Message submitted successfully.')),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.black,
                                  ),
                                  child: const Text('Submit'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 0 : AppSpacing.md, height: isMobile ? AppSpacing.md : 0),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppContent.realtorName, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: AppSpacing.md),
                            const Text('${AppContent.addressLine1}\n${AppContent.addressLine2}'),
                            const SizedBox(height: AppSpacing.sm),
                            _ContactItem(
                              icon: FontAwesomeIcons.phone,
                              label: 'Cell: ${AppContent.phoneCell}',
                              onTap: () => _launchLink('tel:+17038692665'),
                            ),
                            _ContactItem(
                              icon: FontAwesomeIcons.building,
                              label: 'Office: ${AppContent.phoneOffice}',
                              onTap: () => _launchLink('tel:+17036583999'),
                            ),
                            _ContactItem(
                              icon: FontAwesomeIcons.envelope,
                              label: AppContent.email,
                              onTap: () => _launchLink('mailto:${AppContent.email}'),
                            ),
                            _ContactItem(
                              icon: FontAwesomeIcons.globe,
                              label: AppContent.website,
                              onTap: () => _launchLink(AppContent.website),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            const Text(AppContent.workingHours),
                            const SizedBox(height: AppSpacing.lg),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('https://picsum.photos/900/400?map'),
                                  ),
                                ),
                                child: Container(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  alignment: Alignment.center,
                                  child: const Text('Google Maps Placeholder'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
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
