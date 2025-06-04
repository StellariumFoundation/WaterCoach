// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:water_coach/main.dart';

void main() {
  testWidgets('MyApp builds successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that MyApp is indeed rendered.
    // This is a very basic check. A more specific check would be to find
    // a widget that is uniquely part of WaterCoachPage.
    expect(find.byType(MyApp), findsOneWidget);
  });
}
