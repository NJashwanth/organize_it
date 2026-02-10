import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/main.dart';

void main() {
  group('MyApp', () {
    testWidgets('uses ProviderScope and renders SplashScreen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pump();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Organize It'), findsOneWidget);
    });
  });
}
