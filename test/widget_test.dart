// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:bishal_karki_realtor_web/main.dart';

void main() {
  testWidgets('Realtor web page builds', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ScrollSectionController(),
        child: const RealtorWebApp(),
      ),
    );

    expect(
        find.text('Move with clarity.\nLive with confidence.'), findsOneWidget);
    expect(find.text('Featured Listings'), findsOneWidget);
  });
}
