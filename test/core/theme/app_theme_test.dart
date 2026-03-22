import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('light and dark themes are material3', () {
      final light = AppTheme.light();
      final dark = AppTheme.dark();

      expect(light.useMaterial3, isTrue);
      expect(dark.useMaterial3, isTrue);
    });

    test('text theme extensions map to base styles', () {
      final light = AppTheme.light();
      final textTheme = light.textTheme;

      expect(textTheme.header1, textTheme.displayLarge);
      expect(textTheme.title2, textTheme.titleMedium);
      expect(textTheme.body3, textTheme.bodySmall);
    });

    test('color scheme extensions resolve colors', () {
      final light = AppTheme.light();
      final colors = light.colorScheme;

      expect(colors.tileBackground, colors.surface);
      expect(colors.primaryText, colors.onSurface);
      expect(colors.lowPriority, colors.primary);
    });
  });
}
