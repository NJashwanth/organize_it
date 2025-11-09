import 'package:flutter/material.dart';

/// ================================
/// TEXT STYLE EXTENSIONS
/// ================================
extension AppTextStyleX on TextTheme {
  // Headers
  TextStyle get header1 => displayLarge!;
  TextStyle get header2 => displayMedium!;
  TextStyle get header3 => displaySmall!;

  // Titles
  TextStyle get title1 => titleLarge!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get title2 => titleMedium!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get title3 => titleSmall!.copyWith(fontWeight: FontWeight.w500);

  // Body
  TextStyle get body1 => bodyLarge!;
  TextStyle get body2 => bodyMedium!;
  TextStyle get body3 => bodySmall!;

  // Labels
  TextStyle get label1 => labelLarge!;
  TextStyle get label2 => labelMedium!;
  TextStyle get label3 => labelSmall!;

  // Special
  TextStyle get listTitle => titleMedium!.copyWith(fontWeight: FontWeight.w600);
  TextStyle get listDescription => bodyMedium!;
  TextStyle get sectionHeader =>
      titleLarge!.copyWith(fontWeight: FontWeight.bold);
  TextStyle get caption => bodySmall!;
  TextStyle get tag => labelSmall!.copyWith(fontWeight: FontWeight.w600);
}

/// ================================
/// COLOR EXTENSIONS
/// ================================
extension AppColorSchemeX on ColorScheme {
  Color get tileBackground => surface;
  Color get completedTileBackground => surfaceContainerHighest.withValues(alpha: 0.5);

  // Text
  Color get primaryText => onSurface;
  Color get secondaryText => onSurfaceVariant;
  Color get disabledText => onSurfaceVariant.withValues(alpha: 0.6);

  // Priority
  Color get highPriority => error;
  Color get mediumPriority => tertiary;
  Color get lowPriority => inversePrimary;

  // Status
  Color get statusActive => primary;
  Color get statusCompleted => onSurfaceVariant.withValues(alpha: 0.7);

  // Border
  Color get tileBorder => outlineVariant.withValues(alpha: 0.3);
  Color get completedTileBorder => outlineVariant;
}

/// ================================
/// APP THEME
/// ================================
class AppTheme {
static const Color _primaryLight = Color(0xFF2E8B57); // Emerald Green
static const Color _secondaryLight = Color(0xFF66BB6A); // Mint
static const Color _tertiaryLight = Color(0xFFDCE775); // Light Lime
static const Color _errorLight = Color(0xFFF0625D); // Coral Red

static const Color _primaryDark = Color(0xFF81C784); // Soft green glow
static const Color _secondaryDark = Color(0xFF388E3C); // Deep forest tone
static const Color _tertiaryDark = Color(0xFF9CCC65); // Muted lime
static const Color _errorDark = Color(0xFFFF8A80); // Warm coral red


  // LIGHT THEME
  static ThemeData light() {
    const colorScheme = ColorScheme(
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
      surface: Colors.white,
      onSurface: Color(0xFF1C1B1F),
      surfaceContainerHighest: Color(0xFFE7E0EC),
      onSurfaceVariant: Color(0xFF49454F),
      outline: Color(0xFF79747E),
      outlineVariant: Color(0xFFCAC4D0),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF313033),
      onInverseSurface: Color(0xFFF4EFF4),
      inversePrimary: Color(0xFFD0BCFF),
    );

    final base = ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
    return _baseTheme(base, colorScheme);
  }

  // DARK THEME
  static ThemeData dark() {
    const colorScheme = ColorScheme(
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
      surface: Color(0xFF1C1B1F),
      onSurface: Color(0xFFE6E1E5),
      surfaceContainerHighest: Color(0xFF49454F),
      onSurfaceVariant: Color(0xFFCAC4D0),
      outline: Color(0xFF938F99),
      outlineVariant: Color(0xFF49454F),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFFE6E1E5),
      onInverseSurface: Color(0xFF313033),
      inversePrimary: Color(0xFF6750A4),
    );

    final base = ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
    return _baseTheme(base, colorScheme);
  }

  /// Unified base setup for both light & dark themes
  static ThemeData _baseTheme(ThemeData base, ColorScheme colorScheme) {
    return base.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      cardTheme: CardThemeData(
        elevation: 1,
        color: colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.8),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: colorScheme.surfaceVariant,
        selectedColor: colorScheme.primaryContainer,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: colorScheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      primaryIconTheme: IconThemeData(color: colorScheme.primary),
    );
  }
}
