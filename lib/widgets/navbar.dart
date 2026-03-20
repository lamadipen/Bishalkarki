import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../main.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key, required this.sectionController});

  final ScrollSectionController sectionController;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: const Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: AppSpacing.lg,
        right: AppSpacing.lg,
      ),
      child: SizedBox(
        height: 76,
        child: Row(
          children: [
            Text(
              '${AppContent.company} | ${AppContent.realtorName}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.textPrimary),
            ),
            const Spacer(),
            if (isMobile)
              Builder(
                builder: (ctx) => IconButton(
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                  icon: const Icon(Icons.menu),
                ),
              )
            else
              Wrap(
                spacing: AppSpacing.lg,
                children: [
                  _NavTextButton(label: 'Home', id: 'home'),
                  _NavTextButton(label: 'About', id: 'about'),
                  _NavTextButton(label: 'Listings', id: 'listings'),
                  _NavTextButton(label: 'Services', id: 'services'),
                  _NavTextButton(label: 'Testimonials', id: 'testimonials'),
                  _NavTextButton(label: 'Contact', id: 'contact'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.sectionController});
  final ScrollSectionController sectionController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: ListView(
          children: [
            const ListTile(
              title: Text(
                AppContent.realtorName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            _drawerItem(context, 'Home', 'home'),
            _drawerItem(context, 'About', 'about'),
            _drawerItem(context, 'Listings', 'listings'),
            _drawerItem(context, 'Services', 'services'),
            _drawerItem(context, 'Testimonials', 'testimonials'),
            _drawerItem(context, 'Contact', 'contact'),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, String id) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        sectionController.scrollToSection(id);
      },
    );
  }
}

class _NavTextButton extends StatelessWidget {
  const _NavTextButton({required this.label, required this.id});
  final String label;
  final String id;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<ScrollSectionController>().scrollToSection(id),
      child: Text(label),
    );
  }
}
