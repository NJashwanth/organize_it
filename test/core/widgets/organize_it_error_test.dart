import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/core/widgets/organize_it_error.dart';

void main() {
  group('OrganizeItError', () {
    testWidgets('renders title and message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OrganizeItError(
              title: 'Oops',
              message: 'Something went wrong',
            ),
          ),
        ),
      );

      expect(find.text('Oops'), findsOneWidget);
      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('renders details when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OrganizeItError(
              title: 'Oops',
              message: 'Something went wrong',
              details: 'Details here',
            ),
          ),
        ),
      );

      expect(find.text('Details here'), findsOneWidget);
    });

    testWidgets('invokes action when pressed', (tester) async {
      var called = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OrganizeItError(
              title: 'Oops',
              message: 'Something went wrong',
              actionLabel: 'Retry',
              onAction: () => called = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(called, isTrue);
    });
  });
}
