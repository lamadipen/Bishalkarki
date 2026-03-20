import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'theme.dart';
import 'widgets/about_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer.dart';
import 'widgets/hero_section.dart';
import 'widgets/listings_section.dart';
import 'widgets/navbar.dart';
import 'widgets/services_section.dart';
import 'widgets/testimonials_section.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ScrollSectionController(),
      child: const RealtorWebApp(),
    ),
  );
}

class RealtorWebApp extends StatelessWidget {
  const RealtorWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${AppContent.realtorName} | ${AppContent.role}',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScrollSectionController>().attachScrollController(
            _scrollController,
          );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sectionController = context.watch<ScrollSectionController>();

    return Scaffold(
      drawer: MediaQuery.of(context).size.width < 900
          ? AppDrawer(
              sectionController: sectionController,
            )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: const [
                HeroSection(),
                AboutSection(),
                ListingsSection(),
                ServicesSection(),
                TestimonialsSection(),
                ContactSection(),
                FooterSection(),
              ],
            ),
          ),
          Navbar(sectionController: sectionController),
        ],
      ),
    );
  }
}

class ScrollSectionController extends ChangeNotifier {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final listingsKey = GlobalKey();
  final servicesKey = GlobalKey();
  final testimonialsKey = GlobalKey();
  final contactKey = GlobalKey();
  void attachScrollController(ScrollController controller) {}

  void scrollToSection(String id) {
    final key = switch (id) {
      'home' => homeKey,
      'about' => aboutKey,
      'listings' => listingsKey,
      'services' => servicesKey,
      'testimonials' => testimonialsKey,
      'contact' => contactKey,
      _ => homeKey,
    };

    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: id == 'home' ? 0 : 0.08,
    );
  }
}
