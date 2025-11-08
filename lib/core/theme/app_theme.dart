import 'package:flutter/material.dart';

/// Extension to provide semantic text styles
extension AppTextStyleX on TextTheme {
  // Headers
  TextStyle get header1 => displayLarge!;
  TextStyle get header2 => displayMedium!;
  TextStyle get header3 => displaySmall!;

  // Titles
  TextStyle get title1 => titleLarge!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get title2 => titleMedium!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get title3 => titleSmall!.copyWith(fontWeight: FontWeight.w500);

  // Body text
  TextStyle get body1 => bodyLarge!;
  TextStyle get body2 => bodyMedium!;
  TextStyle get body3 => bodySmall!;

  // Labels
  TextStyle get label1 => labelLarge!;
  TextStyle get label2 => labelMedium!;
  TextStyle get label3 => labelSmall!;

  // Special styles
  TextStyle get listTitle => titleMedium!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get listDescription => bodyMedium!;
  TextStyle get sectionHeader =>
      titleLarge!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get caption => bodySmall!;
  TextStyle get tag => labelSmall!.copyWith(fontWeight: FontWeight.w500);
}

/// Extension to provide semantic colors
extension AppColorSchemeX on ColorScheme {
  // Background colors
  Color get tileBackground => surface;
  Color get completedTileBackground => surfaceVariant.withOpacity(0.5);

  // Text colors
  Color get primaryText => onSurface;
  Color get secondaryText => onSurfaceVariant;
  Color get disabledText => onSurfaceVariant.withOpacity(0.6);

  // Priority colors using theme's color system with distinct colors
  Color get highPriority =>
      error; // Critical tasks - error color for high visibility
  Color get mediumPriority =>
      tertiary; // Warning level - tertiary provides good distinction
  Color get lowPriority =>
      inversePrimary; // Subtle tasks - inverse primary for clear difference

  // Status colors
  Color get statusActive => primary;
  Color get statusCompleted => onSurfaceVariant.withOpacity(0.7);

  // Border colors
  Color get tileBorder => outline.withOpacity(0.2);
  Color get completedTileBorder => outlineVariant;
}

class AppTheme {
  // Brand Colors
  static const Color _primaryLight = Color(0xFF6750A4);
  static const Color _secondaryLight = Color(0xFF7F67BE);
  static const Color _tertiaryLight = Color(0xFFB4A9D6);
  static const Color _errorLight = Color(0xFFBA1A1A);

  static const Color _primaryDark = Color(0xFFD0BCFF);
  static const Color _secondaryDark = Color(0xFFCCC2DC);
  static const Color _tertiaryDark = Color(0xFFEFB8C8);
  static const Color _errorDark = Color(0xFFFFB4AB);

  static ThemeData light() {
    final base = ThemeData.light();

    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: _primaryLight,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFEADDFF),
      onPrimaryContainer: Color(0xFF21005D),
      secondary: _secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE8DEF8),
      onSecondaryContainer: Color(0xFF1D192B),
      tertiary: _tertiaryLight,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFFFD8E4),
      onTertiaryContainer: Color(0xFF31111D),
      error: _errorLight,
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      background: Colors.white,
      onBackground: Color(0xFF1C1B1F),
      surface: Colors.white,
      onSurface: Color(0xFF1C1B1F),
      surfaceVariant: Color(0xFFE7E0EC),
      onSurfaceVariant: Color(0xFF49454F),
      outline: Color(0xFF79747E),
      outlineVariant: Color(0xFFCAC4D0),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF313033),
      onInverseSurface: Color(0xFFF4EFF4),
      inversePrimary: Color(0xFFD0BCFF),
    );

    return base.copyWith(
      colorScheme: colorScheme,
      useMaterial3: true,
      brightness: Brightness.light,

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colorScheme.surface,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 57,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: base.textTheme.displayMedium?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 45,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: base.textTheme.displaySmall?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: base.textTheme.headlineLarge?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 32,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: base.textTheme.titleSmall?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: base.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: base.textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: base.textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: base.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceVariant,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      primaryIconTheme: IconThemeData(color: colorScheme.primary),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark();

    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: _primaryDark,
      onPrimary: Color(0xFF381E72),
      primaryContainer: Color(0xFF4F378B),
      onPrimaryContainer: Color(0xFFEADDFF),
      secondary: _secondaryDark,
      onSecondary: Color(0xFF332D41),
      secondaryContainer: Color(0xFF4A4458),
      onSecondaryContainer: Color(0xFFE8DEF8),
      tertiary: _tertiaryDark,
      onTertiary: Color(0xFF492532),
      tertiaryContainer: Color(0xFF633B48),
      onTertiaryContainer: Color(0xFFFFD8E4),
      error: _errorDark,
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF1C1B1F),
      onBackground: Color(0xFFE6E1E5),
      surface: Color(0xFF1C1B1F),
      onSurface: Color(0xFFE6E1E5),
      surfaceVariant: Color(0xFF49454F),
      onSurfaceVariant: Color(0xFFCAC4D0),
      outline: Color(0xFF938F99),
      outlineVariant: Color(0xFF49454F),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFFE6E1E5),
      onInverseSurface: Color(0xFF313033),
      inversePrimary: Color(0xFF6750A4),
    );

    return base.copyWith(
      colorScheme: colorScheme,
      useMaterial3: true,
      brightness: Brightness.dark,

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colorScheme.surfaceVariant,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // Text Theme with the same structure as light theme but different colors
      textTheme: TextTheme(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 57,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: base.textTheme.displayMedium?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 45,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: base.textTheme.displaySmall?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: base.textTheme.headlineLarge?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 32,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: base.textTheme.titleSmall?.copyWith(
          color: colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: base.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        labelLarge: base.textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: base.textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: base.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceVariant,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      primaryIconTheme: IconThemeData(color: colorScheme.primary),

      // List Tile Theme
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
