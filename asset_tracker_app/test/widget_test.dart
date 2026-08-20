// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:asset_tracker_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AssetTrackerApp());

    // Verify that our app title exists on the screen.
    expect(find.text('IT Asset Tracker'), findsOneWidget);
    
    // Verify that the "View Available Assets" button exists.
    expect(find.text('View Available Assets'), findsOneWidget);

    // Verify that the old counter '0' does NOT exist anymore.
    expect(find.text('0'), findsNothing);
  });
}
