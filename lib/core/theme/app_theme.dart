import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light();

    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: Colors.blue,
        secondary: Colors.amber,
      ),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      // Card theme left as default to maintain compatibility across SDKs.
      textTheme: base.textTheme.copyWith(
        titleLarge:
            base.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        titleMedium:
            base.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(fontSize: 14),
        bodySmall: base.textTheme.bodySmall?.copyWith(fontSize: 12),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
