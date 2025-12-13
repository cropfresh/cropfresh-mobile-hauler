// CropFresh Haulers App Widget Tests
// Currently a placeholder - actual tests to be implemented

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cropfresh_mobile_hauler/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CropFreshHaulerApp());

    // Verify app launches without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
