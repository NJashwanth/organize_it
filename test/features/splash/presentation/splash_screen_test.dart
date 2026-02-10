import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/splash/presentation/splash_screen.dart';

void main() {
  group('SplashScreen', () {
    testWidgets('shows brand title', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

      expect(find.text('Organize It'), findsOneWidget);
    });
  });
}
