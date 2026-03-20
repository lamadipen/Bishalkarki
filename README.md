# Bishal Karki Realtor - Flutter Web

A modern, single-page Flutter web application for Realtor **Bishal Karki** at **IKON Realty**, designed with a premium real estate presentation style.

## Features

- Sticky responsive navigation with smooth section scrolling
- Hero banner with animated tagline and clear CTAs
- About section with animated stat counters
- Featured listings grid with hover interactions
- Services cards with iconography
- Testimonials carousel
- Contact form and contact info panel with tappable links
- Branded footer with social links and quick navigation

## Tech Stack

- Flutter Web
- Provider (state + section scroll controller)
- `google_fonts`
- `font_awesome_flutter`
- `animated_text_kit`
- `flutter_staggered_animations`
- `url_launcher`
- `carousel_slider`

## Project Structure

```text
lib/
├── main.dart
├── theme.dart
├── constants.dart
└── widgets/
    ├── navbar.dart
    ├── hero_section.dart
    ├── about_section.dart
    ├── listings_section.dart
    ├── services_section.dart
    ├── testimonials_section.dart
    ├── contact_section.dart
    └── footer.dart
```

## Run Locally

1. Ensure Flutter stable is installed:
   - `flutter --version`
2. Initialize Flutter scaffolding in this folder if needed:
   - `flutter create .`
3. Get dependencies:
   - `flutter pub get`
4. Run on Chrome:
   - `flutter run -d chrome`

## Build for Production

```bash
flutter build web
```
