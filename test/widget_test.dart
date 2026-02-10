import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organize_it/main.dart';

void main() {
  testWidgets('MyApp renders the splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();

    expect(find.text('Organize It'), findsOneWidget);
  });
}
