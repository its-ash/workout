import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout/main.dart';

void main() {
  group('Workout App Tests', () {
    testWidgets('App launches and shows workout title', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const WorkoutApp());

      // Verify that the app title is present
      expect(find.text('Daily Workout'), findsOneWidget);
      
      // Verify that there's a refresh button
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Loading indicator appears initially', (WidgetTester tester) async {
      await tester.pumpWidget(const WorkoutApp());
      
      // Should show loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}