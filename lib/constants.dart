import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF090909);
  static const Color surface = Color(0xFF121212);
  static const Color card = Color(0xFF1A1A1A);
  static const Color primary = Color(0xFFC59D5F);
  static const Color primaryDark = Color(0xFF9D7B48);
  static const Color textPrimary = Color(0xFFF4F4F4);
  static const Color textSecondary = Color(0xFFCFCFCF);
  static const Color divider = Color(0xFF2D2D2D);
}

class AppSpacing {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double section = 90;
  static const double maxContentWidth = 1200;
}

class AppContent {
  static const String realtorName = 'Bishal Karki';
  /// Portrait for About section (replace with a vertical headshot for best results).
  static const String aboutAgentPortraitAsset = 'assets/images/about_agent.jpg';

  /// “MEET BISHAL” style line — uses first name only, uppercase.
  static String get aboutMeetHeadline {
    final parts = realtorName.trim().split(RegExp(r'\s+'));
    final first = parts.isEmpty ? realtorName : parts.first;
    return 'MEET ${first.toUpperCase()}';
  }
  static const String role = 'Realtor';
  static const String company = 'IKON Realty';
  static const String tagline = 'Top 1% Realtor in USA';
  static const String phoneCell = '(703) 869-2665';
  static const String phoneOffice = '(703) 658-3999';
  static const String email = 'realtorbishal@gmail.com';
  static const String website = 'https://bishalkarki.ikonrealtydmv.com';
  static const String addressLine1 = '3554 Chain Bridge Road';
  static const String addressLine2 = 'Suite 305, Fairfax, VA 22030';
  static const String linkedIn = 'https://www.linkedin.com';
  static const String facebook = 'https://www.facebook.com';
  static const String instagram = 'https://www.instagram.com';
  static const String whatsapp = 'https://wa.me/17038692665';
  static const String workingHours = 'Mon - Sat: 9:00 AM - 7:00 PM';

  /// Homes.com agent page — use for “View all” and as a fallback until each card has its own listing URL.
  static const String homesAgentListingsUrl =
      'https://www.homes.com/real-estate-agents/bishal-karki/clq2nsf/';
}
