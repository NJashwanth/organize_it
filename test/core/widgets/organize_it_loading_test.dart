import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/core/widgets/organize_it_loading.dart';

void main() {
  group('OrganizeItLoading', () {
    testWidgets('renders brand and default message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: OrganizeItLoading())),
      );

      expect(find.text('Organize It'), findsOneWidget);
      expect(
        find.text('Please wait while we fetch your tasks'),
        findsOneWidget,
      );
    });

    testWidgets('renders custom message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: OrganizeItLoading(message: 'Loading...')),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
    });
  });
}
